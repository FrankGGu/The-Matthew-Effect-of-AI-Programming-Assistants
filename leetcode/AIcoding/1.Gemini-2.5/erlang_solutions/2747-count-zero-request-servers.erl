-module(solution).
-export([countZeroRequestServers/2]).

countZeroRequestServers(Logs, Queries) ->
    % Convert logs to [{Time, ServerId}] and sort by Time
    SortedLogs = lists:sort(fun({T1, _}, {T2, _}) -> T1 =< T2 end,
                            [{Time, ServerId} || [ServerId, Time] <- Logs]),
    SortedLogsArray = array:from_list(SortedLogs),
    MaxLogIdx = array:size(SortedLogsArray), % 0-indexed size

    % Get all unique server IDs
    AllServerIds = gb_sets:from_list([ServerId || [ServerId, _] <- Logs]),
    NumUniqueServers = gb_sets:size(AllServerIds),

    % Convert queries to [{QueryTime, Duration, OriginalIndex}] and sort by QueryTime
    IndexedQueries = [{T, D, Idx} || [[T, D], Idx] <- lists:zip(Queries, lists:seq(0, length(Queries) - 1))],
    SortedQueries = lists:sort(fun({T1, _, _}, {T2, _, _}) -> T1 =< T2 end,
                               IndexedQueries),

    % Initialize results array
    ResultsArray = array:new(length(Queries), 0),

    % Initial state for foldl
    InitialState = #{
        log_left_ptr => 0, % 0-indexed
        log_right_ptr => 0, % 0-indexed
        current_server_counts => #{}
    },

    % Process queries
    FinalState = lists:foldl(
        fun({QueryTime, Duration, OriginalIndex}, Acc) ->
            WindowStart = QueryTime - Duration,
            WindowEnd = QueryTime,

            LogLeftPtr = maps:get(log_left_ptr, Acc),
            LogRightPtr = maps:get(log_right_ptr, Acc),
            CurrentServerCounts = maps:get(current_server_counts, Acc),

            % Add logs to the right of the window
            {NewLogRightPtr, UpdatedServerCounts1} = add_logs_to_window(
                LogRightPtr, SortedLogsArray, MaxLogIdx, WindowEnd, CurrentServerCounts
            ),

            % Remove logs from the left of the window
            {NewLogLeftPtr, UpdatedServerCounts2} = remove_logs_from_window(
                LogLeftPtr, NewLogRightPtr, SortedLogsArray, WindowStart, UpdatedServerCounts1
            ),

            % Calculate result for current query
            ServersWithRequests = maps:size(UpdatedServerCounts2),
            ZeroRequestServers = NumUniqueServers - ServersWithRequests,

            % Update results array
            UpdatedResultsArray = array:set(OriginalIndex, ZeroRequestServers, maps:get(results_array, Acc)),

            % Return updated accumulator
            Acc#{
                log_left_ptr => NewLogLeftPtr,
                log_right_ptr => NewLogRightPtr,
                current_server_counts => UpdatedServerCounts2,
                results_array => UpdatedResultsArray
            }
        end,
        InitialState#{results_array => ResultsArray},
        SortedQueries
    ),
    array:to_list(maps:get(results_array, FinalState)).

add_logs_to_window(LogRightPtr, SortedLogsArray, MaxLogIdx, WindowEnd, CurrentServerCounts) ->
    add_logs_loop(LogRightPtr, MaxLogIdx, SortedLogsArray, WindowEnd, CurrentServerCounts).

add_logs_loop(LogRightPtr, MaxLogIdx, SortedLogsArray, WindowEnd, CurrentServerCounts) when LogRightPtr < MaxLogIdx ->
    {LogTime, ServerId} = array:get(LogRightPtr, SortedLogsArray),
    if LogTime =< WindowEnd ->
        UpdatedCounts = maps:update_with(ServerId, fun(C) -> C + 1 end, 1, CurrentServerCounts),
        add_logs_loop(LogRightPtr + 1, MaxLogIdx, SortedLogsArray, WindowEnd, UpdatedCounts);
    true ->
        {LogRightPtr, CurrentServerCounts}
    end;
add_logs_loop(LogRightPtr, _MaxLogIdx, _SortedLogsArray, _WindowEnd, CurrentServerCounts) ->
    {LogRightPtr, CurrentServerCounts}.

remove_logs_from_window(LogLeftPtr, LogRightPtr, SortedLogsArray, WindowStart, CurrentServerCounts) ->
    remove_logs_loop(LogLeftPtr, LogRightPtr, SortedLogsArray, WindowStart, CurrentServerCounts).

remove_logs_loop(LogLeftPtr, LogRightPtr, SortedLogsArray, WindowStart, CurrentServerCounts) when LogLeftPtr < LogRightPtr ->
    {LogTime, ServerId} = array:get(LogLeftPtr, SortedLogsArray),
    if LogTime < WindowStart ->
        Count = maps:get(ServerId, CurrentServerCounts),
        UpdatedCounts = if Count > 1 -> maps:put(ServerId, Count - 1, CurrentServerCounts);
                          true -> maps:remove(ServerId, CurrentServerCounts)
                        end,
        remove_logs_loop(LogLeftPtr + 1, LogRightPtr, SortedLogsArray, WindowStart, UpdatedCounts);
    true ->
        {LogLeftPtr, CurrentServerCounts}
    end;
remove_logs_loop(LogLeftPtr, _LogRightPtr, _SortedLogsArray, _WindowStart, CurrentServerCounts) ->
    {LogLeftPtr, CurrentServerCounts}.
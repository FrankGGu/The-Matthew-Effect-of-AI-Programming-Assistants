-module(solution).
-export([alert_names/2]).

alert_names(KeyName, KeyTime) ->
    % 1. Combine keyName and keyTime, then parse time strings to minutes
    Events = lists:zip(KeyName, KeyTime),
    ParsedEvents = lists:map(fun({Name, TimeStr}) -> {Name, parse_time(TimeStr)} end, Events),

    % 2. Group events by person's name
    Grouped = lists:foldl(fun({Name, Time}, Acc) ->
                                  maps:update_with(Name, fun(Times) -> [Time | Times] end, [Time], Acc)
                          end, #{}, ParsedEvents),

    % 3. For each person, sort their access times
    SortedGrouped = maps:map(fun(_Name, Times) -> lists:sort(Times) end, Grouped),

    % 4. Filter for people who have 3 or more accesses within a 1-hour period
    AlertNamesMap = maps:filter(fun(_Name, SortedTimes) -> check_person_times(SortedTimes) end, SortedGrouped),

    % 5. Extract the names of alerting people and sort them alphabetically
    Names = maps:keys(AlertNamesMap),
    lists:sort(Names).

parse_time(TimeStr) ->
    [H_str, M_str] = string:tokens(TimeStr, ":"),
    list_to_integer(H_str) * 60 + list_to_integer(M_str).

check_person_times([_T1, _T2]) -> false; % Not enough entries for a triplet
check_person_times([T1, _T2, T3 | Rest]) ->
    if
        T3 - T1 =< 60 -> true; % Found a triplet within 60 minutes
        true -> check_person_times([_T2, T3 | Rest]) % Slide the window to the next possible triplet
    end;
check_person_times(_ShortList) -> false. % Empty list or single entry
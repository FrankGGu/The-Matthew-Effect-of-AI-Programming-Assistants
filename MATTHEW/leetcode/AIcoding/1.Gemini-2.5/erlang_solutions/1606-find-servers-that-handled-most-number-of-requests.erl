-module(solution).
-export([find_servers_that_handled_most_number_of_requests/3]).

find_servers_that_handled_most_number_of_requests(K, ArrivalTimes, Loads) ->
    N = length(ArrivalTimes),

    % Initialize request counts for K servers.
    % Using Erlang's array module for O(log K) updates.
    RequestCounts = array:new({0, K-1}, 0), % Array of K zeros, indices 0 to K-1

    % BusyServersPQ: A min-priority queue (gb_trees) storing {FinishTime, ServerId} tuples.
    % Keys are {FinishTime, ServerId}, values are ServerId (or true, value doesn't matter much).
    % Tuples are ordered lexicographically, so it acts as a min-heap on FinishTime, then ServerId.
    BusyServersPQ = gb_trees:empty(),

    % AvailableServersSet: A set (gb_trees) of available server IDs.
    % Keys are ServerId, values are true. This allows efficient lookup_ge and get_min.
    AvailableServersSet = gb_trees:from_list([{S, true} || S <- lists:seq(0, K-1)]),

    % Process each request by folding over the requests.
    % The state (RequestCounts, BusyServersPQ, AvailableServersSet) is passed through recursion.
    % lists:zip is used to combine request index, arrival time, and load for easier iteration.
    InitialState = #{
        request_counts => RequestCounts,
        busy_servers_pq => BusyServersPQ,
        available_servers_set => AvailableServersSet
    },

    RequestsWithIndex = lists:zip(lists:seq(0, N-1), lists:zip(ArrivalTimes, Loads)),

    FinalState = lists:foldl(
        fun({Idx, {ArrivalTime, Load}}, AccState) ->
            process_request(Idx, ArrivalTime, Load, K, AccState)
        end,
        InitialState,
        RequestsWithIndex
    ),

    FinalRequestCounts = FinalState#{request_counts},

    % Find the maximum number of requests handled by any server.
    MaxRequests = array:foldl(fun(_, Val, Acc) -> max(Val, Acc) end, 0, FinalRequestCounts),

    % Collect all server IDs that handled the maximum number of requests.
    Result = array:foldl(
        fun(ServerId, Count, Acc) ->
            if Count == MaxRequests -> [ServerId | Acc];
               true -> Acc
            end
        end,
        [],
        FinalRequestCounts
    ),
    lists:reverse(Result). % Return server IDs in ascending order

process_request(Idx, ArrivalTime, Load, K, State) ->
    RequestCounts = State#{request_counts},
    BusyServersPQ = State#{busy_servers_pq},
    AvailableServersSet = State#{available_servers_set},

    FinishTime = ArrivalTime + Load,
    StartSearchIdx = Idx rem K,

    % 1. Release servers that have finished their tasks by ArrivalTime.
    % Servers whose finish time is <= ArrivalTime become available.
    {NewBusyServersPQ, NewAvailableServersSet} = 
        release_servers(BusyServersPQ, AvailableServersSet, ArrivalTime),

    % 2. Find an available server according to the problem's search rules.
    ServerToAssign = find_server(NewAvailableServersSet, StartSearchIdx),

    % 3. Assign the request if a server was found.
    if ServerToAssign /= -1 ->
        % Update request count for the assigned server.
        UpdatedRequestCounts = array:set(ServerToAssign, array:get(ServerToAssign, RequestCounts) + 1, RequestCounts),
        % Remove the assigned server from the available set.
        UpdatedAvailableServersSet = gb_trees:delete(ServerToAssign, NewAvailableServersSet),
        % Add the server to the busy priority queue with its new finish time.
        UpdatedBusyServersPQ = gb_trees:insert({FinishTime, ServerToAssign}, ServerToAssign, NewBusyServersPQ),
        #{
            request_counts => UpdatedRequestCounts,
            busy_servers_pq => UpdatedBusyServersPQ,
            available_servers_set => UpdatedAvailableServersSet
        };
       true -> % No server found, the request is dropped.
               % The state remains as is after releasing servers (RequestCounts is not updated).
        #{
            request_counts => RequestCounts,
            busy_servers_pq => NewBusyServersPQ,
            available_servers_set => NewAvailableServersSet
        }
    end.

release_servers(BusyPQ, AvailableSet, CurrentTime) ->
    case gb_trees:is_empty(BusyPQ) of
        true -> 
            {BusyPQ, AvailableSet};
        false ->
            {{MinFinishTime, ServerId}, _Value} = gb_trees:get_min(BusyPQ),
            if MinFinishTime =< CurrentTime ->
                % Server has finished, move it from busy to available.
                NewBusyPQ = gb_trees:delete_min(BusyPQ),
                NewAvailableSet = gb_trees:insert(ServerId, true, AvailableSet),
                release_servers(NewBusyPQ, NewAvailableSet, CurrentTime);
               true -> % The earliest finishing server is still busy, so no other server can be free.
                {BusyPQ, AvailableSet}
            end
    end.

find_server(AvailableSet, StartSearchIdx) ->
    case gb_trees:is_empty(AvailableSet) of
        true -> 
            -1; % No servers are currently available
        false ->
            % Try to find the smallest server ID >= StartSearchIdx in the available set.
            case gb_trees:lookup_ge(StartSearchIdx, AvailableSet) of
                {value, ServerId, _Value} ->
                    ServerId; % Found a server in the range [StartSearchIdx, K-1]
                _ -> % No server with ID >= StartSearchIdx, wrap around to the smallest available ID.
                    {{MinServerId, _Value}, _Value2} = gb_trees:get_min(AvailableSet),
                    MinServerId
            end
    end.
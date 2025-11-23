-module(solution).
-export([max_path_quality/3]).

max_path_quality(Values, Edges, MaxTime) ->
    N = length(Values),
    ValuesArr = array:from_list(Values),
    Graph = build_graph(Edges),
    MaxQualityRef = atomics:new(1, [{signed, false}]),
    atomics:put(MaxQualityRef, 1, 0),

    % Initial call: Start at node 0, time 0, current path quality 0 (before adding node 0's value),
    % empty visit counts array.
    dfs(0, 0, 0, array:new(N, {default, 0}), ValuesArr, Graph, MaxTime, MaxQualityRef),

    atomics:get(MaxQualityRef, 1).

build_graph(Edges) ->
    lists:foldl(fun([U, V, T], Acc) ->
        Acc1 = maps:update_with(U, fun(L) -> [{V, T} | L] end, [{V, T}], Acc),
        maps:update_with(V, fun(L) -> [{U, T} | L] end, [{U, T}], Acc1)
    end, #{}, Edges).

dfs(CurrentNode, CurrentTime, CurrentPathQuality, NodeVisitCounts, ValuesArr, Graph, MaxTime, MaxQualityRef) ->
    NodeVal = array:get(CurrentNode, ValuesArr),
    VisitCount = array:get(CurrentNode, NodeVisitCounts),

    NewPathQuality =
        case VisitCount of
            0 -> CurrentPathQuality + NodeVal;
            _ -> CurrentPathQuality
        end,

    UpdatedNodeVisitCounts = array:set(CurrentNode, VisitCount + 1, NodeVisitCounts),

    % If we are at node 0, this is a valid path end point. Update max quality.
    % The problem states "A path starts and ends at node 0".
    % So, any time we reach node 0, it's a potential path end.
    % The initial state (node 0, time 0) is also a valid path.
    % The quality is calculated *after* processing the current node.
    case CurrentNode of
        0 -> atomics:update_max(MaxQualityRef, 1, NewPathQuality);
        _ -> ok
    end,

    Neighbors = maps:get(CurrentNode, Graph, []),
    lists:foreach(fun({Neighbor, EdgeTime}) ->
        If CurrentTime + EdgeTime =< MaxTime then
            dfs(Neighbor, CurrentTime + EdgeTime, NewPathQuality, UpdatedNodeVisitCounts, ValuesArr, Graph, MaxTime, MaxQualityRef)
        end
    end, Neighbors).
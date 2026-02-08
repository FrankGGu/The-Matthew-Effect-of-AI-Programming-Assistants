-module(solution).
-export([maxPoints/2]).

dijkstra(Grid, M, N) ->
    Infinity = 1000000000000000000,

    % Initialize min_path_val with Infinity (1D array)
    MinPathVal0 = array:new(M * N, [{default, Infinity}]),

    % Set starting cell (0,0)
    GridVal00 = get_grid_val(0, 0, Grid),
    MinPathVal1 = array:set(0 * N + 0, GridVal00, MinPathVal0),

    % Priority queue: {MaxValOnPath, R, C}
    % Using gb_trees as a min-priority queue
    PQ0 = gb_trees:insert(GridVal00, {0, 0}, gb_trees:empty()),

    dijkstra_loop(PQ0, MinPathVal1, Grid, M, N, Infinity).

dijkstra_loop(PQ, MinPathVal, Grid, M, N, Infinity) ->
    case gb_trees:is_empty(PQ) of
        true -> MinPathVal;
        false ->
            {{CurrentMaxVal, {R, C}}, PQ1} = gb_trees:take_smallest(PQ),

            CurrentMinPathValRC = array:get(R * N + C, MinPathVal),

            if CurrentMaxVal > CurrentMinPathValRC ->
                dijkstra_loop(PQ1, MinPathVal, Grid, M, N, Infinity);
            true ->
                Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

                {NewPQ, NewMinPathVal} = lists:foldl(
                    fun({NR, NC}, {AccPQ, AccMinPathVal}) ->
                        if 
                            NR >= 0, NR < M, NC >= 0, NC < N ->
                                GridValNRC = get_grid_val(NR, NC, Grid),
                                NewMaxVal = max(CurrentMaxVal, GridValNRC),

                                CurrentMinPathValNRC = array:get(NR * N + NC, AccMinPathVal),

                                if NewMaxVal < CurrentMinPathValNRC ->
                                    UpdatedMinPathVal = array:set(NR * N + NC, NewMaxVal, AccMinPathVal),
                                    UpdatedPQ = gb_trees:insert(NewMaxVal, {NR, NC}, AccPQ),
                                    {UpdatedPQ, UpdatedMinPathVal};
                                true ->
                                    {AccPQ, AccMinPathVal}
                                end;
                            true ->
                                {AccPQ, AccMinPathVal}
                        end
                    end,
                    {PQ1, MinPathVal},
                    Neighbors
                ),
                dijkstra_loop(NewPQ, NewMinPathVal, Grid, M, N, Infinity)
            end
    end.

get_grid_val(R, C, Grid) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

maxPoints(Grid, Queries) ->
    M = length(Grid),
    N = length(hd(Grid)),

    MinPathValArray = dijkstra(Grid, M, N),

    Infinity = 1000000000000000000,

    ReachableMaxVals = lists:foldl(
        fun(Idx, Acc) ->
            Val = array:get(Idx, MinPathValArray),
            if Val < Infinity -> [Val | Acc];
            true -> Acc
            end
        end, [], lists:seq(0, M * N - 1)
    ),

    SortedReachableMaxVals = lists:sort(ReachableMaxVals),

    QueriesWithIndex = lists:zip(Queries, lists:seq(0, length(Queries) - 1)),

    SortedQueriesWithIndex = lists:sort(fun({Q1, _}, {Q2, _}) -> Q1 < Q2 end, QueriesWithIndex),

    ResultsArray = array:new(length(Queries), [{default, 0}]),

    {_FinalCount, _FinalReachableIdx, FinalResultsArray} = lists:foldl(
        fun({QueryVal, OriginalIdx}, {CurrentCount, ReachableIdx, AccResultsArray}) ->
            {UpdatedCount, UpdatedReachableIdx} = 
                count_reachable(QueryVal, CurrentCount, ReachableIdx, SortedReachableMaxVals),

            UpdatedResultsArray = array:set(OriginalIdx, UpdatedCount, AccResultsArray),

            {UpdatedCount, UpdatedReachableIdx, UpdatedResultsArray}
        end,
        {0, 0, ResultsArray},
        SortedQueriesWithIndex
    ),

    array:to_list(FinalResultsArray).

count_reachable(QueryVal, CurrentCount, ReachableIdx, SortedReachableMaxVals) ->
    LenReachable = length(SortedReachableMaxVals),
    count_reachable_loop(QueryVal, CurrentCount, ReachableIdx, SortedReachableMaxVals, LenReachable).

count_reachable_loop(QueryVal, Count, Idx, SortedList, Len) ->
    if Idx < Len, lists:nth(Idx + 1, SortedList) < QueryVal ->
        count_reachable_loop(QueryVal, Count + 1, Idx + 1, SortedList, Len);
    true ->
        {Count, Idx}
    end.
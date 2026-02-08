-module(solution).
-export([getAncestors/2]).

dfs_internal(CurrentNode, RevAdj, VisitedSet) ->
    if sets:is_element(CurrentNode, VisitedSet) ->
            VisitedSet;
        true ->
            NewVisitedSet = sets:add_element(CurrentNode, VisitedSet),
            Neighbors = array:get(CurrentNode, RevAdj),
            lists:foldl(fun(Neighbor, AccSet) ->
                                dfs_internal(Neighbor, RevAdj, AccSet)
                        end, NewVisitedSet, Neighbors)
    end.

getAncestors(N, Edges) ->
    RevAdj = array:new(N, []),
    RevAdj1 = lists:foldl(
        fun([From, To], AccRevAdj) ->
            CurrentList = array:get(To, AccRevAdj),
            array:set(To, [From | CurrentList], AccRevAdj)
        end, RevAdj, Edges),

    AncestorsResultArray = array:new(N),

    FinalAncestorsArray = lists:foldl(
        fun(I, AccAncestorsResult) ->
            VisitedSet = dfs_internal(I, RevAdj1, sets:new()),

            ActualAncestorsSet = sets:remove_element(I, VisitedSet),

            SortedAncestors = lists:sort(sets:to_list(ActualAncestorsSet)),

            array:set(I, SortedAncestors, AccAncestorsResult)
        end, AncestorsResultArray, lists:seq(0, N-1)),

    array:to_list(FinalAncestorsArray).
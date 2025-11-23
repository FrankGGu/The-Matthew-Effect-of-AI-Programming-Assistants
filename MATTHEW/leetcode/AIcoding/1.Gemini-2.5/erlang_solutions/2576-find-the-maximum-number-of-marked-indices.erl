-module(solution).
-export([solve/1]).

solve(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    LeftHalfLen = N div 2,
    {LeftList, RightList} = lists:split(LeftHalfLen, SortedNums),

    find_max_marked(LeftList, RightList, 0).

find_max_marked([], _RightList, Count) ->
    Count;
find_max_marked(_LeftList, [], Count) ->
    Count;
find_max_marked([L | LRest], [R | RRest], Count) ->
    if 2 * L =< R ->
        find_max_marked(LRest, RRest, Count + 1);
    else ->
        find_max_marked([L | LRest], RRest, Count)
    end.
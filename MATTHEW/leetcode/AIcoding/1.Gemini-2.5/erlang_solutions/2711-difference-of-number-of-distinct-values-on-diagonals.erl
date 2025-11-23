-module(solution).
-export([difference_of_distinct_values/1]).

difference_of_distinct_values(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    GridTuples = [list_to_tuple(Row) || Row <- Grid],
    GridTupleOfTuples = list_to_tuple(GridTuples),

    GetElement = fun(R, C) ->
        element(C + 1, element(R + 1, GridTupleOfTuples))
    end,

    GetDistinctTopLeft = fun(R, C) ->
        MaxK = min(R, C),
        Sets = sets:new(),
        lists:foldl(
            fun(K, AccSets) ->
                Val = GetElement(R - K, C - K),
                sets:add_element(Val, AccSets)
            end,
            Sets,
            lists:seq(0, MaxK)
        )
    end,

    GetDistinctBottomRight = fun(R, C) ->
        MaxK = min(M - 1 - R, N - 1 - C),
        Sets = sets:new(),
        lists:foldl(
            fun(K, AccSets) ->
                Val = GetElement(R + K, C + K),
                sets:add_element(Val, AccSets)
            end,
            Sets,
            lists:seq(0, MaxK)
        )
    end,

    [
        [
            begin
                TL_Set = GetDistinctTopLeft(R, C),
                BR_Set = GetDistinctBottomRight(R, C),
                abs(sets:size(TL_Set) - sets:size(BR_Set))
            end
        || C <- lists:seq(0, N - 1) ]
    || R <- lists:seq(0, M - 1) ]
.
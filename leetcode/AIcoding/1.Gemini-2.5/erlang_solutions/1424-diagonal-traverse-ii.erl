-module(solution).
-export([findDiagonalOrder/1]).

findDiagonalOrder(Nums) ->
    % Build a map where keys are diagonal sums (r + c) and values are lists of elements.
    % Elements are prepended to their respective diagonal list to achieve the correct order
    % (bottom-left to top-right within each diagonal).
    DiagonalsMap = build_diagonals(Nums, 0, #{}),

    % Convert the map to a list of {Sum, ElementsList} tuples and sort by Sum.
    SortedDiagonals = lists:sort(
        fun({K1, _}, {K2, _}) -> K1 < K2 end,
        maps:to_list(DiagonalsMap)
    ),

    % Concatenate all the sorted diagonal lists into a single result list.
    lists:flatmap(fun({_, List}) -> List end, SortedDiagonals).

build_diagonals([], _RIdx, AccMap) ->
    AccMap;
build_diagonals([CurrentRow | RestRows], RIdx, AccMap) ->
    % For each element in the current row, calculate its diagonal sum (RIdx + CIdx),
    % and prepend it to the corresponding list in the accumulator map.
    NewAccMap = lists:foldl(
        fun({Val, CIdx}, InnerAccMap) ->
            Sum = RIdx + CIdx,
            CurrentList = maps:get(Sum, InnerAccMap, []),
            maps:put(Sum, [Val | CurrentList], InnerAccMap)
        end,
        AccMap,
        lists:zip(CurrentRow, lists:seq(0, length(CurrentRow) - 1)) % Pair values with their column index
    ),
    build_diagonals(RestRows, RIdx + 1, NewAccMap).
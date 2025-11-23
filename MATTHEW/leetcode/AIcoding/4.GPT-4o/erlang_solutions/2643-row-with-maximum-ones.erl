-module(solution).
-export([row_with_max_ones/1]).

row_with_max_ones(Matrix) ->
    RowWithMaxOnes = lists:foldl(fun(Row, {Index, MaxIndex, MaxCount}) ->
        Count = lists:sum(Row),
        if
            Count > MaxCount -> {Index, Index, Count};
            true -> {Index + 1, MaxIndex, MaxCount}
        end
    end, {0, -1, 0}, lists:reverse(Matrix)),
    element(2, RowWithMaxOnes).
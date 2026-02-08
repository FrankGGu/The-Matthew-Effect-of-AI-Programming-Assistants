-module(solution).
-export([generate/1]).

generate(0) -> [];
generate(1) -> [[1]];
generate(NumRows) when NumRows > 1 ->
    PrevRows = generate(NumRows - 1),
    PrevRow = lists:last(PrevRows),
    CurrentRow = [1 | sum_adjacent(PrevRow) | 1],
    PrevRows ++ [CurrentRow].

sum_adjacent([_]) -> [];
sum_adjacent([]) -> [];
sum_adjacent([A, B | T]) ->
    [A + B | sum_adjacent([B | T])].
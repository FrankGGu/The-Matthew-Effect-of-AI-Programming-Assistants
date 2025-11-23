-module(solution).
-export([min_swaps/1]).

min_swaps(Grid) ->
    Rows = length(Grid),
    Matrix = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= 1 -> 1; true -> 0 end) end, Row) end, Grid),
    TargetRows = lists:map(fun(Row) -> count_trailing_zeros(Row) end, Matrix),
    SortedTargetRows = lists:sort(TargetRows),
    count_swaps(TargetRows, SortedTargetRows, 0).

count_trailing_zeros(Row) ->
    case lists:reverse(Row) of
        [] -> 0;
        [0 | Tail] -> 1 + count_trailing_zeros(Tail);
        _ -> 0
    end.

count_swaps([], [], Acc) -> Acc;
count_swaps([H1 | T1], [H2 | T2], Acc) when H1 =:= H2 -> count_swaps(T1, T2, Acc);
count_swaps([H1 | T1], [H2 | T2], Acc) -> 
    case lists:prefix([H2], T1) of
        true -> count_swaps(T1, T2, Acc + 1);
        false -> count_swaps(T1, [H1 | T2], Acc)
    end.
-module(solution).
-export([min_operations/2]).

min_operations(A, K) ->
    Sorted = lists:sort(A),
    Total = lists:sum(Sorted),
    min_ops(Sorted, Total, K, 0).

min_ops([], Total, K, Ops) when Total >= K -> Ops;
min_ops([], _, _, _) -> -1;
min_ops([H | T], Total, K, Ops) ->
    NewTotal = Total - H + 2 * H,
    if
        NewTotal >= K -> min_ops(T, NewTotal, K, Ops + 1);
        true -> min_ops(T, Total, K, Ops)
    end.
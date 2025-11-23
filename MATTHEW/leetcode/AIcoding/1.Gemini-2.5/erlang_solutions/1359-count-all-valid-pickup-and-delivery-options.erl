-module(solution).
-export([count_orders/1]).

-spec count_orders(N :: integer()) -> integer().
count_orders(N) ->
    Mod = 1000000007,
    count_orders_recursive(N, 1, Mod).

count_orders_recursive(0, Acc, _Mod) ->
    Acc;
count_orders_recursive(N, Acc, Mod) ->
    % Calculate Acc * N * (2*N - 1) % Mod
    NewAcc1 = (Acc * N) rem Mod,
    NewAcc2 = (NewAcc1 * (2*N - 1)) rem Mod,
    count_orders_recursive(N - 1, NewAcc2, Mod).
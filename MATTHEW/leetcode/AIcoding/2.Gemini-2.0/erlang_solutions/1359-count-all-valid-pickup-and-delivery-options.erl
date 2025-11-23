-module(valid_pickup_delivery).
-export([countOrders/1]).

countOrders(N) ->
    countOrders_helper(N).

countOrders_helper(N) ->
    fact(2*N) div (fact(N) * power(2, N)) rem 1000000007.

fact(0) -> 1;
fact(N) -> (N * fact(N-1)) rem 1000000007.

power(X, 0) -> 1;
power(X, N) ->
    if N rem 2 == 0 ->
        Half = power(X, N div 2),
        (Half * Half) rem 1000000007;
    true ->
        (X * power(X, N-1)) rem 1000000007
    end.
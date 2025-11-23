-module(solution).
-export([max_number/1]).

max_number(K) ->
    max_number(K, 1, 0).

max_number(_K, _N, _Sum) when _N > 1000000 -> 0;
max_number(K, N, Sum) ->
    Price = price(N),
    if
        Sum + Price =< K -> max_number(K, N + 1, Sum + Price);
        true -> N - 1
    end.

price(N) ->
    price(N, 0).

price(0, Acc) -> Acc;
price(N, Acc) ->
    price(N div 10, Acc + (N rem 10)).
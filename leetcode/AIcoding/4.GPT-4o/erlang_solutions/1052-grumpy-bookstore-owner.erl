-module(solution).
-export([max_happy/2]).

max_happy(N, Customers) ->
    max_happy_helper(N, Customers, 0, 0).

max_happy_helper(_, [], Happy, _) -> 
    Happy;
max_happy_helper(N, [{G, Y} | Rest], Happy, 0) when G =:= 1 ->
    max_happy_helper(N, Rest, Happy + Y, 1);
max_happy_helper(N, [{G, Y} | Rest], Happy, 1) when G =:= 1 ->
    max_happy_helper(N, Rest, Happy, 1);
max_happy_helper(N, [{G, Y} | Rest], Happy, 0) when G =:= 0 ->
    max_happy_helper(N, Rest, Happy, 0);
max_happy_helper(N, [{G, Y} | Rest], Happy, 1) when G =:= 0 ->
    max_happy_helper(N, Rest, Happy, 0 + Y).
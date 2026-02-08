-module(solution).
-export([find_x/1]).

find_x(Nums) ->
    find_x(Nums, 0).

find_x([], _X) ->
    -1;
find_x([N | Rest], X) ->
    case lists:all(fun(E) -> E >= X end, Nums) andalso lists:all(fun(E) -> E <= X end, Nums) of
        true -> X;
        false -> find_x(Rest, X + 1)
    end.
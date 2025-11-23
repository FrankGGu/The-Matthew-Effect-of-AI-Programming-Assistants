-module(solution).
-export([split_digits/1]).

split_digits(Ns) ->
    lists:flatmap(fun(N) -> split_number(N, []) end, Ns).

split_number(0, Acc) ->
    lists:reverse(Acc);
split_number(N, Acc) ->
    split_number(N div 10, [N rem 10 | Acc]).
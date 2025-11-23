-module(solution).
-export([make_equal/2]).

make_equal(Num1, Num2) ->
    D1 = digits(Num1),
    D2 = digits(Num2),
    case length(D1) == length(D2) of
        true ->
            lists:sum(lists:zipwith(fun(X, Y) -> abs(X - Y) end, D1, D2));
        false ->
            -1
    end.

digits(0) -> [];
digits(N) when N > 0 -> digits(N div 10) ++ [N rem 10].
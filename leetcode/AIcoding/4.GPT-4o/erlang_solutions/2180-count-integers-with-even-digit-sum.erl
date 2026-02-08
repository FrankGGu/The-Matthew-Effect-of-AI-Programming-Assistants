-module(solution).
-export([count_even_digit_sum/1]).

count_even_digit_sum(N) ->
    lists:sum([1 || X <- lists:seq(1, N), is_even_digit_sum(X)]).

is_even_digit_sum(X) ->
    Sum = lists:sum(digits(X)),
    Sum rem 2 == 0.

digits(0) -> [];
digits(N) -> digits(N, []).
digits(0, Acc) -> lists:reverse(Acc);
digits(N, Acc) -> digits(N div 10, [N rem 10 | Acc]).
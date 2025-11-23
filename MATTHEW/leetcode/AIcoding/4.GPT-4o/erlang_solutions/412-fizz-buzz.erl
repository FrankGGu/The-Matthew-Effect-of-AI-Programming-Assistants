-module(solution).
-export([fizz_buzz/1]).

-spec fizz_buzz(integer()) -> [unicode:unicode_binary()].
fizz_buzz(N) ->
    lists:map(fun(I) -> fizz_buzz_string(I) end, lists:seq(1, N)).

fizz_buzz_string(I) when I rem 3 =:= 0, I rem 5 =:= 0 -> "FizzBuzz";
fizz_buzz_string(I) when I rem 3 =:= 0 -> "Fizz";
fizz_buzz_string(I) when I rem 5 =:= 0 -> "Buzz";
fizz_buzz_string(I) -> integer_to_list(I).

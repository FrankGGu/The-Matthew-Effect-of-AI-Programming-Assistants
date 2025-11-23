-module(fizz_buzz).
-export([fizz_buzz/1]).

fizz_buzz(N) ->
    lists:map(fun(I) -> fizz_buzz_helper(I) end, lists:seq(1, N)).

fizz_buzz_helper(I) ->
    case {I rem 3 == 0, I rem 5 == 0} of
        {true, true} -> "FizzBuzz";
        {true, false} -> "Fizz";
        {false, true} -> "Buzz";
        _ -> integer_to_list(I)
    end.
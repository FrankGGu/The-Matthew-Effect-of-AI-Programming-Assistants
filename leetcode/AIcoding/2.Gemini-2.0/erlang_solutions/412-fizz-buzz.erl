-module(fizzbuzz).
-export([fizzbuzz/1]).

fizzbuzz(N) ->
  lists:map(fun(I) ->
                case {I rem 3 == 0, I rem 5 == 0} of
                  {true, true} -> "FizzBuzz";
                  {true, false} -> "Fizz";
                  {false, true} -> "Buzz";
                  {false, false} -> integer_to_list(I)
                end
            end, lists:seq(1, N)).
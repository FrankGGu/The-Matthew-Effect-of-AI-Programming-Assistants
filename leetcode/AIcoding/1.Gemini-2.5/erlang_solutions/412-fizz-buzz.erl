-module(solution).
-export([fizzbuzz/1]).

fizzbuzz(N) ->
    [get_string(I) || I <- lists:seq(1, N)].

get_string(Num) when Num rem 15 == 0 ->
    "FizzBuzz";
get_string(Num) when Num rem 3 == 0 ->
    "Fizz";
get_string(Num) when Num rem 5 == 0 ->
    "Buzz";
get_string(Num) ->
    integer_to_list(Num).
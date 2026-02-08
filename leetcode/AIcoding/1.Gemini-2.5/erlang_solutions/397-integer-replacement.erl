-module(integer_replacement).
-export([integerReplacement/1]).

integerReplacement(1) -> 0;
integerReplacement(N) when N rem 2 == 0 ->
    1 + integerReplacement(N div 2);
integerReplacement(3) ->
    1 + integerReplacement(N - 1);
integerReplacement(N) when N rem 4 == 1 ->
    1 + integerReplacement(N - 1);
integerReplacement(N) when N rem 4 == 3 ->
    1 + integerReplacement(N + 1).
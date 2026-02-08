-module(sneaky_numbers).
-export([sneaky_numbers/1]).

sneaky_numbers(N) ->
  [X, Y] = lists:sort(lists:usort([A * B || A <- lists:seq(1, trunc(math:sqrt(N))),
                                      B <- lists:seq(A, N div A),
                                      A * B =< N,
                                      N rem (A * B) =:= 0])),
  [X, N div X].
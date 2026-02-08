-module(solution).
-export([powerful_integers/3]).

powerful_integers(X, Y, B) ->
    MaxX = math:floor(math:log(B) / math:log(X)) + 1,
    MaxY = math:floor(math:log(B) / math:log(Y)) + 1,
    Sets = lists:seq(0, MaxX),
    SetsY = lists:seq(0, MaxY),
    Integers = [X^i + Y^j || i <- Sets, j <- SetsY, X^i + Y^j <= B],
    lists:usort(Integers).
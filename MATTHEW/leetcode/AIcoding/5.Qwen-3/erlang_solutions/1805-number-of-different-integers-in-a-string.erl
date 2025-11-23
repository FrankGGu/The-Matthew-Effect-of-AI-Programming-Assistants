-module(solution).
-export([number_of_different_integers/1]).

number_of_different_integers(S) ->
    Ints = re:split(S, "[^0-9]+", [{return, list}, {trim, true}]),
    UniqueInts = lists:usort([list_to_integer(I) || I <- Ints, I /= ""]),
    length(UniqueInts).
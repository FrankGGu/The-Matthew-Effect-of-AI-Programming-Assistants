-module(solution).
-compile([export_all]).

-spec find_the_difference(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> char().
find_the_difference(S, T) ->
    find_the_difference(S, T, 0).

find_the_difference([], [H | _], Acc) -> H;
find_the_difference([H | T1], [H | T2], Acc) -> 
    find_the_difference(T1, T2, Acc);
find_the_difference([H | _], [H1 | _], Acc) -> 
    H1.

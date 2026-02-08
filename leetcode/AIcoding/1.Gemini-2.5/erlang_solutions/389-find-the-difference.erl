-module(solution).
-export([find_the_difference/2]).

-spec find_the_difference(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> char().
find_the_difference(S, T) ->
    S_chars = unicode:characters_to_list(S),
    T_chars = unicode:characters_to_list(T),
    lists:foldl(fun(Char, Acc) -> Acc bxor Char end, 0, S_chars ++ T_chars).
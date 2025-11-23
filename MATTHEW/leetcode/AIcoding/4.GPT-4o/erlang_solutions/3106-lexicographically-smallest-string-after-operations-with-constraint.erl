-module(solution).
-export([smallestString/2]).

smallestString(N, S) ->
    chars = list_to_tuple(string:to_list(S)),
    smallestStringHelper(N, chars, 0).

smallestStringHelper(N, Chars, Index) ->
    if
        Index >= N -> 
            list_to_string(tuple_to_list(Chars));
        true ->
            NewChars = updateChars(Chars, Index),
            Smallest = smallestStringHelper(N, NewChars, Index + 1),
            if 
                Smallest < list_to_string(tuple_to_list(Chars)) ->
                    Smallest;
                true ->
                    list_to_string(tuple_to_list(Chars))
            end
    end.

updateChars(Chars, Index) ->
    New = tuple_to_list(Chars),
    case lists:nth(Index + 1, New) of
        $z -> Chars;
        _ -> 
            lists:nth(Index + 1, New + [$a])
    end.
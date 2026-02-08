-module(consistent_strings).
-export([countConsistentStrings/2]).

countConsistentStrings(Allowed, Words) ->
    AllowedSet = string:to_list(Allowed),
    lists:foldl(
        fun(Word, Acc) ->
            case is_consistent(string:to_list(Word), AllowedSet) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        Words
    ).

is_consistent([], _) -> true;
is_consistent([H|T], Allowed) ->
    case lists:member(H, Allowed) of
        true -> is_consistent(T, Allowed);
        false -> false
    end.
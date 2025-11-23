-module(remove_duplicate_letters).
-export([remove_duplicate_letters/1]).

remove_duplicate_letters(S) ->
    remove_duplicate_letters(S, [], []).

remove_duplicate_letters([], Stack, _) ->
    lists:reverse(Stack);
remove_duplicate_letters([H|T], Stack, Seen) ->
    Remaining = length([X || X <- T, X == H]),
    case lists:member(H, Seen) of
        true ->
            remove_duplicate_letters(T, Stack, Seen);
        false ->
            remove_duplicate_letters(H, T, Stack, Seen, Remaining)
    end.

remove_duplicate_letters(H, T, Stack, Seen, Remaining) ->
    case Stack of
        [] ->
            remove_duplicate_letters(T, [H|Stack], [H|Seen]);
        [Top|Rest] ->
            case (H < Top) and (Remaining > 0) of
                true ->
                    remove_duplicate_letters(H, T, Rest, lists:delete(Top, Seen), Remaining);
                false ->
                    remove_duplicate_letters(T, [H|Stack], [H|Seen])
            end
    end.
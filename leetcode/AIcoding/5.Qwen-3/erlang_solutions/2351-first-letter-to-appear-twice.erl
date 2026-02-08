-module(first_letter_to_appear_twice).
-export([repeatedCharacter/1]).

repeatedCharacter(S) ->
    repeatedCharacter(S, #{}).

repeatedCharacter([], _) ->
    $;
repeatedCharacter([C | T], Map) ->
    case maps:is_key(C, Map) of
        true ->
            C;
        false ->
            repeatedCharacter(T, maps:put(C, 1, Map))
    end.
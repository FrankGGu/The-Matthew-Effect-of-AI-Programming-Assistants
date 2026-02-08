-module(solution).
-export([repeated_character/1]).

repeated_character(S) ->
    repeated_character(S, maps:new()).

repeated_character([], _) ->
    <<>>;
repeated_character([H | T], Seen) ->
    case maps:is_key(H, Seen) of
        true -> H;
        false -> repeated_character(T, maps:put(H, true, Seen))
    end.
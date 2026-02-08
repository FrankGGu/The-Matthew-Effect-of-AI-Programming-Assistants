-module(wildcard_matching).
-export([is_match/2]).

is_match(S, P) ->
    is_match(S, P, 0, 0, []).

is_match([], [], _, _, _) ->
    true;
is_match([], P, _, _, _) ->
    case P of
        "*" ++ _ -> true;
        _ -> false
    end;
is_match(S, [], _, _, _) ->
    false;
is_match([C | S], [C | P], I, J, Back) ->
    is_match(S, P, I + 1, J + 1, Back);
is_match([C | S], ["*" | P], I, J, Back) ->
    is_match(S, P, I + 1, J + 1, [{I, J} | Back]);
is_match([C | S], [PChar | P], I, J, Back) ->
    case Back of
        [] ->
            false;
        [{I0, J0} | Rest] ->
            is_match(S, [PChar | P], I + 1, J + 1, [{I0, J0} | Rest])
    end.
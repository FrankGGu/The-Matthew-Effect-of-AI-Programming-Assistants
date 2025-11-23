-module(regular_expression_matching).
-export([is_match/2]).

is_match(S, P) ->
    is_match(S, P, 0, 0).

is_match([], [], _, _) -> true;
is_match([], P, _, PPos) ->
    case P of
        [_, $*, _ | _] -> is_match([], P, PPos + 2, PPos + 2);
        _ -> false
    end;
is_match(S, [], SPos, _) ->
    case S of
        [ _| _ ] -> false;
        _ -> true
    end;
is_match([C | S], [C | P], SPos, PPos) ->
    is_match(S, P, SPos + 1, PPos + 1);
is_match([C | S], [$. | P], SPos, PPos) ->
    is_match(S, P, SPos + 1, PPos + 1);
is_match([C | S], [_, $*, Next | Rest], SPos, PPos) ->
    case Next of
        $* -> is_match([C | S], [Next | Rest], SPos, PPos + 1);
        _ -> 
            case is_match([C | S], Rest, SPos, PPos + 2) of
                true -> true;
                _ -> 
                    case is_match(S, [_, $*, Next | Rest], SPos + 1, PPos) of
                        true -> true;
                        _ -> false
                    end
            end
    end;
is_match([C | S], [_, $*, _ | _], SPos, PPos) ->
    is_match(S, [_, $*, _ | _], SPos + 1, PPos);
is_match([C | S], [_, $*, _ | _], SPos, PPos) ->
    is_match(S, [_, $*, _ | _], SPos + 1, PPos);
is_match([C | S], [_, $*, _ | _], SPos, PPos) ->
    is_match(S, [_, $*, _ | _], SPos + 1, PPos);
is_match(_, _, _, _) -> false.
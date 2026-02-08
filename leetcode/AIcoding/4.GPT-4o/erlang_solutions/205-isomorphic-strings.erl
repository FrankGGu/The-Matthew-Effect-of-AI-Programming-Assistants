-spec is_isomorphic(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_isomorphic(S, T) ->
    is_isomorphic(S, T, #{}, #{}).

is_isomorphic([], [], _, _) -> true;
is_isomorphic([H1 | T1], [H2 | T2], M1, M2) ->
    case maps:get(H1, M1, undefined) of
        undefined ->
            case maps:get(H2, M2, undefined) of
                undefined ->
                    is_isomorphic(T1, T2, maps:put(H1, H2, M1), maps:put(H2, H1, M2));
                _ -> false
            end;
        Val -> Val =:= H2 andalso is_isomorphic(T1, T2, M1, M2)
    end.

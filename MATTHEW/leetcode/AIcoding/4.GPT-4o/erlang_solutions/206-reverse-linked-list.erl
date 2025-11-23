-spec is_isomorphic(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_isomorphic(S, T) when length(S) =:= length(T) ->
    is_isomorphic(S, T, dict:new(), dict:new()).
is_isomorphic(_, _) -> false.

is_isomorphic([], [], _, _) -> true;
is_isomorphic([H1 | T1], [H2 | T2], M1, M2) ->
    case {dict:find(H1, M1), dict:find(H2, M2)} of
        {error, _} = NoMapping1, {error, _} = NoMapping2 ->
            is_isomorphic(T1, T2, dict:store(H1, H2, M1), dict:store(H2, H1, M2));
        {error, _} = NoMapping1, {ok, _} -> false;
        {ok, _}, {error, _} = NoMapping2 -> false;
        {ok, Mapped1}, {ok, Mapped2} when Mapped1 =:= H2, Mapped2 =:= H1 -> 
            is_isomorphic(T1, T2, M1, M2);
        _ -> false
    end.

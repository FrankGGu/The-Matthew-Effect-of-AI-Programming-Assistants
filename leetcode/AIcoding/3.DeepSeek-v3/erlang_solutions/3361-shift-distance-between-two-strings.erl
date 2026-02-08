-spec can_convert(s1 :: unicode:unicode_binary(), s2 :: unicode:unicode_binary()) -> boolean().
can_convert(S1, S2) when byte_size(S1) =/= byte_size(S2) -> false;
can_convert(S1, S2) ->
    Maps = maps:new(),
    can_convert(S1, S2, Maps).

can_convert(<<>>, <<>>, _Maps) -> true;
can_convert(<<C1:8, Rest1/binary>>, <<C2:8, Rest2/binary>>, Maps) ->
    case maps:find(C1, Maps) of
        {ok, C2} -> can_convert(Rest1, Rest2, Maps);
        error -> can_convert(Rest1, Rest2, maps:put(C1, C2, Maps));
        {ok, Other} when Other =/= C2 -> false
    end.
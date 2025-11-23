-spec can_be_valid(S :: unicode:unicode_binary(), Locked :: [integer()]) -> boolean().
can_be_valid(S, Locked) ->
    can_be_valid(S, Locked, 0, 0, 0, 0).

can_be_valid(<<>>, [], MinOpen, MaxOpen, _, _) ->
    MinOpen =< 0 andalso 0 =< MaxOpen;
can_be_valid(<<C:8, Rest/binary>>, [L | LockedRest], MinOpen, MaxOpen, I, N) ->
    case L of
        1 ->
            case C of
                $( ->
                    NewMin = max(MinOpen + 1, 0),
                    NewMax = MaxOpen + 1,
                    can_be_valid(Rest, LockedRest, NewMin, NewMax, I + 1, N + 1);
                $) ->
                    NewMin = max(MinOpen - 1, 0),
                    NewMax = MaxOpen - 1,
                    if
                        NewMax < 0 -> false;
                        true -> can_be_valid(Rest, LockedRest, NewMin, NewMax, I + 1, N + 1)
                    end
            end;
        0 ->
            NewMin1 = max(MinOpen - 1, 0),
            NewMax1 = MaxOpen + 1,
            if
                NewMax1 < 0 -> false;
                true ->
                    case can_be_valid(Rest, LockedRest, NewMin1, NewMax1, I + 1, N + 1) of
                        true -> true;
                        false ->
                            NewMin2 = max(MinOpen + 1, 0),
                            NewMax2 = MaxOpen + 1,
                            can_be_valid(Rest, LockedRest, NewMin2, NewMax2, I + 1, N + 1)
                    end
            end
    end;
can_be_valid(_, _, _, _, _, _) ->
    false.
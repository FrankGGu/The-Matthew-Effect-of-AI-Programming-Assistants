-spec can_cross(Stones :: [integer()]) -> boolean().
can_cross(Stones) ->
    N = length(Stones),
    case N of
        0 -> false;
        1 -> true;
        _ ->
            StoneSet = sets:from_list(Stones),
            LastStone = lists:last(Stones),
            DP = maps:new(),
            DP1 = maps:put(1, sets:from_list([1]), DP),
            can_cross(1, 1, StoneSet, LastStone, DP1)
    end.

can_cross(Pos, K, StoneSet, LastStone, DP) ->
    case Pos =:= LastStone of
        true -> true;
        false ->
            case maps:is_key(Pos, DP) of
                false -> false;
                true ->
                    Ks = maps:get(Pos, DP),
                    NextPositions = lists:filtermap(
                        fun(NextK) ->
                            NextPos = Pos + NextK,
                            case sets:is_element(NextPos, StoneSet) of
                                true ->
                                    {true, {NextPos, NextK}};
                                false ->
                                    false
                            end
                        end,
                        sets:to_list(Ks)
                    ),
                    lists:any(
                        fun({NextPos, NextK}) ->
                            NewKs = sets:from_list([NextK - 1, NextK, NextK + 1]),
                            NewKs1 = sets:filter(fun(X) -> X > 0 end, NewKs),
                            case maps:is_key(NextPos, DP) of
                                true ->
                                    ExistingKs = maps:get(NextPos, DP),
                                    Combined = sets:union(ExistingKs, NewKs1),
                                    NewDP = maps:update(NextPos, Combined, DP),
                                    can_cross(NextPos, NextK, StoneSet, LastStone, NewDP);
                                false ->
                                    NewDP = maps:put(NextPos, NewKs1, DP),
                                    can_cross(NextPos, NextK, StoneSet, LastStone, NewDP)
                            end
                        end,
                        NextPositions)
            end
    end.
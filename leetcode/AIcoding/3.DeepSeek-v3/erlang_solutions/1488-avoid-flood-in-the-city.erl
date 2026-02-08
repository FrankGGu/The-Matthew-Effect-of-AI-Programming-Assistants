-spec avoid_flood(Rains :: [integer()]) -> [integer()].
avoid_flood(Rains) ->
    {Result, _, _} = lists:foldl(fun
        (0, {Acc, DryDays, Lakes}) ->
            {[0 | Acc], [length(Acc) | DryDays], Lakes};
        (Lake, {Acc, DryDays, Lakes}) ->
            case maps:find(Lake, Lakes) of
                {ok, Day} ->
                    case lists:search(fun(D) -> D > Day end, DryDays) of
                        {value, DryDay} ->
                            NewDryDays = lists:delete(DryDay, DryDays),
                            NewAcc = replace(Acc, DryDay, Lake),
                            {[ -1 | NewAcc], NewDryDays, maps:remove(Lake, Lakes)};
                        false ->
                            {[], [], #{}}
                    end;
                error ->
                    {[ -1 | Acc], DryDays, maps:put(Lake, length(Acc), Lakes)}
            end
    end, {[], [], #{}}, Rains),
    lists:reverse(Result).

replace(List, Index, Value) ->
    {Left, [_ | Right]} = lists:split(Index, List),
    Left ++ [Value | Right].
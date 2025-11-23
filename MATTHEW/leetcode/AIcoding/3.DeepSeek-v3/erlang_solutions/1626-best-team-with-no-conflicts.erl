-spec best_team_score(Scores :: [integer()], Ages :: [integer()]) -> integer().
best_team_score(Scores, Ages) ->
    Players = lists:zip(Ages, Scores),
    SortedPlayers = lists:sort(fun({A1, S1}, {A2, S2}) ->
        if
            A1 == A2 -> S1 =< S2;
            true -> A1 =< A2
        end
    end, Players),
    DP = lists:map(fun({_, S}) -> S end, SortedPlayers),
    lists:foldl(fun({I, {_, S}}, AccDP) ->
        Max = lists:foldl(fun({J, {_, PrevS}}, CurrentMax) ->
            if
                (PrevS =< S) and (lists:nth(J, AccDP) > CurrentMax) ->
                    lists:nth(J, AccDP);
                true ->
                    CurrentMax
            end
        end, 0, lists:zip(lists:seq(1, I-1), lists:sublist(SortedPlayers, I-1))),
        UpdatedDP = list_update(AccDP, I, Max + S),
        UpdatedDP
    end, DP, lists:zip(lists:seq(1, length(SortedPlayers)), SortedPlayers)),
    lists:max(DP).

list_update(List, Index, Value) ->
    {Before, [_ | After]} = lists:split(Index - 1, List),
    Before ++ [Value | After].
-spec find_winners(Matches :: [[integer()]]) -> [[integer()]].
find_winners(Matches) ->
    Losses = lists:foldl(fun([Winner, Loser], Acc) ->
                            Acc1 = maps:put(Winner, maps:get(Winner, Acc, 0), Acc),
                            maps:put(Loser, maps:get(Loser, Acc1, 0) + 1, Acc1)
                         end, #{}, Matches),
    {Zero, One} = maps:fold(fun(Player, Count, {Z, O}) ->
                                case Count of
                                    0 -> {[Player | Z], O};
                                    1 -> {Z, [Player | O]};
                                    _ -> {Z, O}
                                end
                             end, {[], []}, Losses),
    [lists:sort(Zero), lists:sort(One)].
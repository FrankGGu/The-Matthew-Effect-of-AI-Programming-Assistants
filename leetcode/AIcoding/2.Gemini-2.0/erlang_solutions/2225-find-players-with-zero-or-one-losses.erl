-module(find_players).
-export([find_players_with_zero_or_one_losses/1]).

find_players_with_zero_or_one_losses(Matches) ->
  lists:foldl(fun({Winner, Loser}, {Winners, Losers}) ->
                  {lists:append([Winner], Winners), lists:append([Loser], Losers)}
              end, {[], []}, Matches)
  |> fun({Winners, Losers}) ->
        WinnersSet = sets:from_list(Winners),
        LosersList = lists:sort(Losers),
        ZeroLossPlayers = sets:to_list(sets:difference(WinnersSet, sets:from_list(Losers))),
        OneLossPlayers = [Player || {Player, Count} <- lists:foldl(fun(Player, Acc) ->
                                                                      case lists:keyfind(Player, 1, Acc) of
                                                                        false ->
                                                                          [{Player, 1} | Acc];
                                                                        {Player, C} ->
                                                                          lists:keyreplace(Player, 1, Acc, {Player, C + 1})
                                                                      end
                                                                  end, [], LosersList),
                           Count == 1],
        {[list_to_integer(X) || X <- lists:sort([integer_to_list(P) || P <- ZeroLossPlayers])],
         [list_to_integer(X) || X <- lists:sort([integer_to_list(P) || P <- OneLossPlayers])]}
     end().
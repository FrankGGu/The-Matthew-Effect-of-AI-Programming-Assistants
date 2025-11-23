-module(find_winners).
-export([find_winners/1]).

find_winners(Matches) ->
  lists:foldl(fun({Winner, Loser}, {Winners, Losers}) ->
                  {lists:sort(lists:union([Winner], Winners)),
                   lists:sort(lists:union([Loser], Losers))}
              end, {[], []}, Matches)
  |> fun({Winners, Losers}) ->
         OneLoss = lists:sort([Player || Player <- Losers,
                                 length(lists:filter(fun(L) -> L == Player end, Losers)) == 1]),
         NoLoss = lists:sort([Player || Player <- Winners,
                                not lists:member(Player, Losers)]),
         [NoLoss, OneLoss]
     end().
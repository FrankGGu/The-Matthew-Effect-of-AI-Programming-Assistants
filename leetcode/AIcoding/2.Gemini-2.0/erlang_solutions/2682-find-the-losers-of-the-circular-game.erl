-module(find_losers).
-export([find_losers/2]).

find_losers(N, K) ->
  find_losers(N, K, 1, 1, 1, []).

find_losers(N, K, Player, Round, CurrentK, Losers) ->
  case Round > N of
    true ->
      AllPlayers = lists:seq(1, N),
      Winners = lists:subtract(AllPlayers, Losers),
      lists:sort(Winners);
    false ->
      NextPlayer = (Player + CurrentK - 1) rem N + 1,
      case lists:member(NextPlayer, Losers) of
        true ->
          find_losers(N, K, Player, Round + 1, CurrentK + K, Losers);
        false ->
          find_losers(N, K, Player, Round + 1, CurrentK + K, lists:sort(lists:merge(Losers, [NextPlayer])))
      end
  end.
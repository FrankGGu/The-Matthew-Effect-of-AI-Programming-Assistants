-module(find_winner).
-export([get_winner/2]).

get_winner(Arr, K) ->
  get_winner(Arr, K, 0, hd(Arr)).

get_winner([], _, _, _) -> -1;
get_winner(_, K, Count, _) when Count >= K -> 1;
get_winner(_, K, Count, _) when Count >= K -> 2;
get_winner([H|T], K, Count, Prev) ->
  case H > Prev of
    true ->
      get_winner(T, K, 1, H);
    false ->
      get_winner(T, K, Count + 1, Prev)
  end.
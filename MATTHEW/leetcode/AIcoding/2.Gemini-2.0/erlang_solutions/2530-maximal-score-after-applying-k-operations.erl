-module(maximal_score_after_applying_k_operations).
-export([maximumScore/2]).

maximumScore(Nums, K) ->
  maximumScore(Nums, K, 0, []).

maximumScore(Nums, 0, Score, _) ->
  Score;
maximumScore([], _, Score, _) ->
  Score;
maximumScore(Nums, K, Score, Sorted) ->
  {Max, Rest} = find_max_and_rest(Nums),
  NewScore = Score + Max,
  NewMax = math:ceil(Max / 3),
  maximumScore(Rest ++ [NewMax], K - 1, NewScore, Sorted).

find_max_and_rest([H], []) ->
  {H, []};
find_max_and_rest([H|T], Acc) ->
  find_max_and_rest(T, H, [], Acc).

find_max_and_rest([], Max, Rest, Acc) ->
  {Max, Rest ++ Acc};
find_max_and_rest([H|T], MaxSoFar, Rest, Acc) ->
  case H > MaxSoFar of
    true ->
      find_max_and_rest(T, H, Rest ++ [MaxSoFar], Acc);
    false ->
      find_max_and_rest(T, MaxSoFar, Rest ++ [H], Acc)
  end.
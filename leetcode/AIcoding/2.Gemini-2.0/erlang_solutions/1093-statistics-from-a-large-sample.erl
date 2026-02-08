-module(statistics_from_a_large_sample).
-export([sample_stats/1]).

sample_stats(Counts) ->
  N = lists:sum(Counts),
  Min = find_min(Counts),
  Max = find_max(Counts),
  Mean = find_mean(Counts),
  Median = find_median(Counts),
  Mode = find_mode(Counts),
  [Mean, Median, float(Min), float(Max), float(Mode)].

find_min(Counts) ->
  find_min_helper(Counts, 0).

find_min_helper([H|T], I) ->
  if H > 0 ->
    I
  else
    find_min_helper(T, I + 1)
  end;
find_min_helper([], _) ->
  -1.

find_max(Counts) ->
  find_max_helper(lists:reverse(Counts), 0).

find_max_helper([H|T], I) ->
  if H > 0 ->
    1000 - I
  else
    find_max_helper(T, I + 1)
  end;
find_max_helper([], _) ->
  -1.

find_mean(Counts) ->
  Sum = lists:foldl(fun(Count, {S, I}) -> {S + Count * I, I + 1} end, {0, 0}, Counts),
  {TotalSum, _} = Sum,
  float(TotalSum) / lists:sum(Counts).

find_median(Counts) ->
  N = lists:sum(Counts),
  if N rem 2 == 0 ->
    V1 = find_kth(Counts, N div 2),
    V2 = find_kth(Counts, N div 2 + 1),
    (V1 + V2) / 2.0
  else
    find_kth(Counts, (N + 1) div 2)
  end.

find_kth(Counts, K) ->
  find_kth_helper(Counts, K, 0).

find_kth_helper([H|T], K, I) ->
  if K =< H ->
    I
  else
    find_kth_helper(T, K - H, I + 1)
  end;
find_kth_helper([], _, _) ->
  -1.

find_mode(Counts) ->
  {_, Mode} = lists:foldl(fun(Count, {MaxCount, CurrentMode, I}) ->
                                    if Count > MaxCount ->
                                      {Count, I, I + 1}
                                    else
                                      {MaxCount, CurrentMode, I + 1}
                                    end
                                end, {0, 0, 0}, lists:zipwith(fun(Count, Index) -> {Count, Index} end, Counts, lists:seq(0, length(Counts) - 1))),
  Mode.
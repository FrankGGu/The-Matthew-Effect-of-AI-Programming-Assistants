-module(distinct_averages).
-export([num_distinct_averages/1]).

num_distinct_averages(Nums) ->
  SortedNums = lists:sort(Nums),
  num_distinct_averages_helper(SortedNums, []).

num_distinct_averages_helper([], Acc) ->
  length(Acc);
num_distinct_averages_helper([Min | Rest], Acc) ->
  {Max, NewRest} = lists:last(Rest),
  Avg = (Min + Max) / 2,
  case lists:member(Avg, Acc) of
    true ->
      num_distinct_averages_helper(lists:droplast(Rest), Acc);
    false ->
      num_distinct_averages_helper(lists:droplast(Rest), [Avg | Acc])
  end.
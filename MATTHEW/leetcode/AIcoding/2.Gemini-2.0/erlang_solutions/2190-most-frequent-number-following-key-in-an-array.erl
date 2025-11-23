-module(most_frequent_number_following_key).
-export([mostFrequent/2]).

mostFrequent(Nums, Key) ->
  most_frequent(Nums, Key, #{}, 0, undefined).

most_frequent([], _Key, Counts, MaxCount, MaxVal) ->
  case MaxVal of
    undefined -> 0;
    _ -> MaxVal
  end;

most_frequent([Key, Val | Rest], Key, Counts, MaxCount, MaxVal) ->
  NewCounts = maps:update_with(Val, fun(Count) -> Count + 1 end, 1, Counts),
  Count = maps:get(Val, NewCounts),
  case Count > MaxCount of
    true ->
      most_frequent(Rest, Key, NewCounts, Count, Val);
    false ->
      most_frequent(Rest, Key, NewCounts, MaxCount, MaxVal)
  end;
most_frequent([_ | Rest], Key, Counts, MaxCount, MaxVal) ->
  most_frequent(Rest, Key, Counts, MaxCount, MaxVal).
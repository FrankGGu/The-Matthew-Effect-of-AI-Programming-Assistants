-module(most_competitive_subsequence).
-export([most_competitive/2]).

most_competitive(Nums, K) ->
  most_competitive(Nums, K, [], 0).

most_competitive([], 0, Acc, _) ->
  lists:reverse(Acc);
most_competitive([], _, Acc, _) ->
  lists:reverse(Acc).

most_competitive([H|T], K, Acc, Index) ->
  Len = length(Acc),
  Remaining = length([H|T]),
  if
    Len > 0 andalso H < lists:last(Acc) andalso Len + Remaining > K ->
      most_competitive([H|T], K, lists:droplast(Acc), Index + 1);
    Len < K ->
      most_competitive(T, K, Acc ++ [H], Index + 1);
    true ->
      most_competitive(T, K, Acc, Index + 1)
  end.
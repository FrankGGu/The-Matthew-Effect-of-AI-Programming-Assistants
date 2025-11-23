-module(longest_nice_subarray).
-export([longestNiceSubarray/1]).

longestNiceSubarray(Nums) ->
  longestNiceSubarray(Nums, 0, 0, 0, 0).

longestNiceSubarray([], _, MaxLen, _, _) ->
  MaxLen;
longestNiceSubarray([H|T], L, R, And, MaxLen) ->
  case And band H == 0 of
    true ->
      NewR = R + 1,
      NewAnd = And bor H,
      NewMaxLen = max(MaxLen, NewR - L),
      longestNiceSubarray(T, L, NewR, NewAnd, NewMaxLen);
    false ->
      longestNiceSubarray(T, L + 1, R, and(sublist(lists:nthtail(L+1, lists:nthtail(L, Nums)), R - L)),MaxLen)
  end.

and(L) ->
  and(L, -1).

and([], Acc) -> Acc;
and([H|T], Acc) -> and(T, Acc band H).

sublist(L, Len) ->
  lists:sublist(L, Len).
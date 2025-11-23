-module(strange_printer).
-export([strange_printer/1]).

strange_printer(S) ->
  Str = string:strip(S, both, " "),
  Len = length(Str),
  dp(Str, 1, Len).

dp(Str, I, J) ->
  if I > J ->
    0
  else
    [C | _] = string:slice(Str, I - 1, 1),
    K = find_k(Str, I, J, C),
    dp(Str, I, K) + dp(Str, K + 1, J) - (if K + 1 =< J andalso string:slice(Str, K, 1) =:= string:slice(Str, K + 1, 1) then 1 else 0 end)
  end.

find_k(Str, I, J, C) ->
  find_k_helper(Str, I, J, C, I).

find_k_helper(Str, StrLen, J, C, K) when K > J ->
  J;
find_k_helper(Str, StrLen, J, C, K) ->
  if string:slice(Str, K - 1, 1) == [C] then
    K
  else
    find_k_helper(Str, StrLen, J, C, K + 1)
  end.
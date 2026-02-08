-module(split_palindrome).
-export([checkPalindromeFormation/1]).

checkPalindromeFormation([A, B]) ->
  check(A, B) or check(B, A).

check(A, B) ->
  N = length(A),
  split(A, B, N).

split(A, B, N) ->
  splitHelper(A, B, N, 0).

splitHelper(A, B, N, I) ->
  if
    I >= N div 2 ->
      true;
    lists:nth(I + 1, A) == lists:nth(N - I, B) ->
      splitHelper(A, B, N, I + 1);
    true ->
      checkPrefix(A, N, I) or checkPrefix(B, N, I)
  end.

checkPrefix(S, N, I) ->
  checkPrefixHelper(S, N, I, 0).

checkPrefixHelper(S, N, I, J) ->
  if
    J >= N - 2 * I - 1 div 2 ->
      true;
    lists:nth(I + J + 1, S) == lists:nth(N - I - J, S) ->
      checkPrefixHelper(S, N, I, J + 1);
    true ->
      false
  end.
-module(ugly_number_iii).
-export([nth_ugly_number/2]).

nth_ugly_number(N, [A, B, C]) ->
  L = 1,
  R = 2 * 1000000000,
  binary_search(N, A, B, C, L, R).

binary_search(N, A, B, C, L, R) ->
  if L > R ->
    R;
  true ->
    Mid = L + (R - L) div 2,
    if count_ugly(Mid, A, B, C) < N ->
      binary_search(N, A, B, C, Mid + 1, R);
    true ->
      binary_search(N, A, B, C, L, Mid - 1)
  end.

count_ugly(Num, A, B, C) ->
  Num div A + Num div B + Num div C - Num div lcm(A, B) - Num div lcm(A, C) - Num div lcm(B, C) + Num div lcm(A, lcm(B, C)).

lcm(A, B) ->
  A * B div gcd(A, B).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
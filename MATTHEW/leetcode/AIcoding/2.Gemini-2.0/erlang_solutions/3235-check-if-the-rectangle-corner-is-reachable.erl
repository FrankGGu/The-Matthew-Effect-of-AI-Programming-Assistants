-module(reachable_rectangle).
-export([reachable/2]).

reachable(H, W) ->
  gcd(H, W) == 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
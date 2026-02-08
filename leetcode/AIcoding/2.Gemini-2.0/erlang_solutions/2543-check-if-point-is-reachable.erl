-module(reachable).
-export([is_reachable/2]).

is_reachable(TargetX, TargetY) ->
    gcd(TargetX, TargetY) == 1.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
-module(solution).
-export([isReachable/2]).

isReachable(TargetX, TargetY) ->
    math:gcd(TargetX, TargetY) == 1.
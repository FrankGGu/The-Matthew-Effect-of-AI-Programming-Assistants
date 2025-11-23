-module(solution).
-export([is_reachable/2]).

-spec is_reachable(TargetX :: integer(), TargetY :: integer()) -> boolean().
is_reachable(TargetX, TargetY) ->
    GCD = gcd(TargetX, TargetY),
    is_power_of_two(GCD).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

is_power_of_two(1) -> true;
is_power_of_two(N) when N rem 2 =:= 0 -> is_power_of_two(N div 2);
is_power_of_two(_) -> false.
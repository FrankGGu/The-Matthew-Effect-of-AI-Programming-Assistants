-module(water_jug).
-export([can_measure_water/3]).

can_measure_water(Jug1Capacity, Jug2Capacity, TargetCapacity) ->
  GCD = gcd(Jug1Capacity, Jug2Capacity),
  TargetCapacity rem GCD == 0 and TargetCapacity =< Jug1Capacity + Jug2Capacity.

gcd(0, B) -> B;
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
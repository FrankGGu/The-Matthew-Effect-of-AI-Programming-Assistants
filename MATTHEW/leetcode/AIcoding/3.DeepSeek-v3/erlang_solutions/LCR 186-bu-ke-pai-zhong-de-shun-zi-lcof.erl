-spec can_measure_water(Jug1Capacity :: integer(), Jug2Capacity :: integer(), TargetCapacity :: integer()) -> boolean().
can_measure_water(X, Y, Z) ->
    if
        Z =:= 0 -> true;
        X + Y < Z -> false;
        Z rem gcd(X, Y) =:= 0 -> true;
        true -> false
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
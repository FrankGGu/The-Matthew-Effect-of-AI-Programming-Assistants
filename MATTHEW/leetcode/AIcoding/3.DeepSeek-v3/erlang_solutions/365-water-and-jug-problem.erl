-spec can_measure_water(Jug1Capacity :: integer(), Jug2Capacity :: integer(), TargetCapacity :: integer()) -> boolean().
can_measure_water(X, Y, Z) ->
    if
        Z < 0 -> false;
        Z > X + Y -> false;
        true -> 
            case Z of
                0 -> true;
                _ -> 
                    GCD = gcd(X, Y),
                    Z rem GCD =:= 0
            end
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
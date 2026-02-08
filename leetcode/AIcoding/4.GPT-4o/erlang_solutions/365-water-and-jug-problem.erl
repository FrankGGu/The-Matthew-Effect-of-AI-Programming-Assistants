-spec can_measure_water(X :: integer(), Y :: integer(), Target :: integer()) -> boolean().
can_measure_water(X, Y, Target) when Target > X + Y -> false;
can_measure_water(X, Y, Target) when Target rem gcd(X, Y) =:= 0 -> true;
can_measure_water(_, _, _) -> false.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

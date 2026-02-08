-spec is_reachable(TargetX :: integer(), TargetY :: integer()) -> boolean().
is_reachable(TargetX, TargetY) ->
    GCD = fun
        GCD(0, B) -> B;
        GCD(A, B) -> GCD(B rem A, A)
    end,
    GCD(TargetX, TargetY) band 1 =:= 1.
-spec sum_zero(N :: integer()) -> [integer()].
sum_zero(N) ->
    case N rem 2 of
        1 -> lists:seq(-(N div 2), N div 2);
        0 -> lists:seq(-(N div 2), -1) ++ lists:seq(1, N div 2)
    end.
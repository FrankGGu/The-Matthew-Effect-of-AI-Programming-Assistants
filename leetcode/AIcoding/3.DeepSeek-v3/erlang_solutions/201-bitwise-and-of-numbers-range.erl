-spec range_bitwise_and(Left :: integer(), Right :: integer()) -> integer().
range_bitwise_and(Left, Right) ->
    Shift = 0,
    range_bitwise_and(Left, Right, Shift).

range_bitwise_and(Left, Right, Shift) ->
    case Left =:= Right of
        true -> Left bsl Shift;
        false -> range_bitwise_and(Left bsr 1, Right bsr 1, Shift + 1)
    end.
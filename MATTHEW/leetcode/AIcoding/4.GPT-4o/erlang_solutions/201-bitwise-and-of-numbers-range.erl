-spec range_bitwise_and(Left :: integer(), Right :: integer()) -> integer().
range_bitwise_and(Left, Right) when Left =:= Right -> Left;
range_bitwise_and(Left, Right) ->
    range_bitwise_and(Left bsr 1, Right bsr 1) bsl 1.

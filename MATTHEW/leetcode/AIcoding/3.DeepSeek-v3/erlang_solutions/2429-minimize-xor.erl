-spec minimize_xor(Num1 :: integer(), Num2 :: integer()) -> integer().
minimize_xor(Num1, Num2) ->
    Count = count_bits(Num2),
    X = 0,
    {Result, _} = build_x(Num1, Count, 31, X),
    Result.

count_bits(N) ->
    count_bits(N, 0).

count_bits(0, Acc) -> Acc;
count_bits(N, Acc) ->
    count_bits(N bsr 1, Acc + (N band 1)).

build_x(_Num1, 0, _Bit, X) -> {X, 0};
build_x(Num1, Count, Bit, X) ->
    Mask = 1 bsl Bit,
    case Num1 band Mask of
        Mask ->
            NewX = X bor Mask,
            build_x(Num1, Count - 1, Bit - 1, NewX);
        0 ->
            build_x(Num1, Count, Bit - 1, X)
    end.
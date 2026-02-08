-spec min_flips(A :: integer(), B :: integer(), C :: integer()) -> integer().
min_flips(A, B, C) ->
    min_flips(A, B, C, 0).

min_flips(0, 0, 0, Count) ->
    Count;
min_flips(A, B, C, Count) ->
    A_bit = A band 1,
    B_bit = B band 1,
    C_bit = C band 1,
    case C_bit of
        1 ->
            case (A_bit bor B_bit) =:= 1 of
                true -> NewCount = Count;
                false -> NewCount = Count + 1
            end;
        0 ->
            NewCount = Count + A_bit + B_bit
    end,
    min_flips(A bsr 1, B bsr 1, C bsr 1, NewCount).
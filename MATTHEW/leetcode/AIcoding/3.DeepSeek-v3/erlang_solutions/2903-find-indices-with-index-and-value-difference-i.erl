-spec find_indices(Nums :: [integer()], IndexDifference :: integer(), ValueDifference :: integer()) -> [integer()].
find_indices(Nums, IndexDifference, ValueDifference) ->
    find_indices(Nums, IndexDifference, ValueDifference, 0, length(Nums), -1, -1).

find_indices(Nums, IndexDiff, ValueDiff, I, N, I1, I2) when I < N ->
    Num = lists:nth(I + 1, Nums),
    case I1 =:= -1 orelse abs(I - I1) >= IndexDiff of
        true ->
            case I1 =:= -1 orelse abs(Num - lists:nth(I1 + 1, Nums)) >= ValueDiff of
                true -> {I1, I};
                false -> find_indices(Nums, IndexDiff, ValueDiff, I + 1, N, I1, I2)
            end;
        false ->
            find_indices(Nums, IndexDiff, ValueDiff, I + 1, N, I1, I2)
    end;
find_indices(_, _, _, _, _, I1, I2) ->
    if
        I1 =/= -1 andalso I2 =/= -1 -> [I1, I2];
        true -> [-1, -1]
    end.
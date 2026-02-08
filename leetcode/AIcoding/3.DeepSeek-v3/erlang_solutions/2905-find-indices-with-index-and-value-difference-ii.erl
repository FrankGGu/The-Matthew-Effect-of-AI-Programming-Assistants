-spec find_indices(Nums :: [integer()], IndexDifference :: integer(), ValueDifference :: integer()) -> [integer()].
find_indices(Nums, IndexDifference, ValueDifference) ->
    find_indices(Nums, IndexDifference, ValueDifference, 0, [], length(Nums)).

find_indices(_, _, _, _, Acc, 0) ->
    case Acc of
        [] -> [-1, -1];
        _ -> lists:reverse(Acc)
    end;
find_indices(Nums, IndexDiff, ValueDiff, I, Acc, Len) ->
    case find_j(Nums, I, IndexDiff, ValueDiff, I + 1, Len) of
        -1 -> find_indices(Nums, IndexDiff, ValueDiff, I + 1, Acc, Len - 1);
        J -> [I, J]
    end.

find_j(_, _, _, _, J, Len) when J >= Len -> -1;
find_j(Nums, I, IndexDiff, ValueDiff, J, Len) ->
    if
        abs(I - J) >= IndexDiff andalso abs(lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums)) >= ValueDiff -> J;
        true -> find_j(Nums, I, IndexDiff, ValueDiff, J + 1, Len)
    end.
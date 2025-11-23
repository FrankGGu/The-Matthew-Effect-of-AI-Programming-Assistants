-spec find_center(Edges :: [[integer()]]) -> integer().
find_center(Edges) ->
    [First, Second] = Edges,
    [U1, V1] = First,
    [U2, V2] = Second,
    if
        U1 =:= U2 -> U1;
        U1 =:= V2 -> U1;
        V1 =:= U2 -> V1;
        V1 =:= V2 -> V1
    end.
-spec min_elements(Nums :: [integer()], Limit :: integer(), Goal :: integer()) -> integer().
min_elements(Nums, Limit, Goal) ->
    Sum = lists:sum(Nums),
    Diff = abs(Goal - Sum),
    if
        Diff =:= 0 -> 0;
        true -> (Diff + Limit - 1) div Limit
    end.
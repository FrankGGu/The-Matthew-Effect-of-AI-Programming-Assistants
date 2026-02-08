-spec min_operations(Nums :: [integer()], Target :: [integer()]) -> integer().
min_operations(Nums, Target) ->
    {EvenNums, OddNums} = lists:partition(fun(X) -> X rem 2 == 0 end, Nums),
    {EvenTarget, OddTarget} = lists:partition(fun(X) -> X rem 2 == 0 end, Target),
    SortedEvenNums = lists:sort(EvenNums),
    SortedOddNums = lists:sort(OddNums),
    SortedEvenTarget = lists:sort(EvenTarget),
    SortedOddTarget = lists:sort(OddTarget),
    DiffEven = lists:sum([abs(X - Y) || {X, Y} <- lists:zip(SortedEvenNums, SortedEvenTarget)]),
    DiffOdd = lists:sum([abs(X - Y) || {X, Y} <- lists:zip(SortedOddNums, SortedOddTarget)]),
    (DiffEven + DiffOdd) div 4.
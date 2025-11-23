-module(solution).
-export([countMaxOrSubsets/1]).

countMaxOrSubsets(Nums) ->
    {MaxOr, Count} = countMaxOrSubsetsHelper(Nums, 0, 0, 0),
    Count.

countMaxOrSubsetsHelper([], CurrentOr, MaxOr, Count) ->
    if CurrentOr > MaxOr then
        {CurrentOr, 1}
    else if CurrentOr == MaxOr then
        {MaxOr, Count + 1}
    else
        {MaxOr, Count}
    end;
countMaxOrSubsetsHelper([H|T], CurrentOr, MaxOr, Count) ->
    {MaxOr1, Count1} = countMaxOrSubsetsHelper(T, CurrentOr, MaxOr, Count),
    {MaxOr2, Count2} = countMaxOrSubsetsHelper(T, CurrentOr bor H, MaxOr1, Count1),
    {max(MaxOr1, MaxOr2), Count1 + Count2}.
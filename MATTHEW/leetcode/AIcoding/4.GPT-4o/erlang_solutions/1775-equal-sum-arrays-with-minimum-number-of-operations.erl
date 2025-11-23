-module(solution).
-export([min_operations/2]).

min_operations(A, B) ->
    TotalA = lists:sum(A),
    TotalB = lists:sum(B),
    Diff = TotalA - TotalB,
    if
        Diff == 0 -> 
            0;
        Diff > 0 -> 
            min_operations_helper(A, B, Diff);
        true -> 
            min_operations_helper(B, A, -Diff)
    end.

min_operations_helper(A, B, Diff) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B, >),
    min_operations_helper(SortedA, SortedB, Diff, 0).

min_operations_helper([], _, _, Ops) -> Ops;
min_operations_helper(_, [], _, Ops) -> Ops;
min_operations_helper([AHead | ATail], [BHead | BTail], Diff, Ops) ->
    NewDiff = Diff - (6 - AHead) + (BHead - 1),
    NewOps = Ops + 1,
    if
        NewDiff >= 0 -> 
            min_operations_helper(ATail, [BHead | BTail], NewDiff, NewOps);
        true -> 
            min_operations_helper(ATail, BTail, Diff, Ops)
    end.
-spec rob(Nums :: [integer()]) -> integer().
rob(Nums) ->
    case Nums of
        [] -> 0;
        [X] -> X;
        [X, Y] -> max(X, Y);
        _ ->
            Len = length(Nums),
            Max1 = rob_helper(lists:sublist(Nums, 1, Len - 1)),
            Max2 = rob_helper(lists:sublist(Nums, 2, Len - 1)),
            max(Max1, Max2)
    end.

rob_helper(Nums) ->
    {Prev1, Prev2} = {0, 0},
    rob_helper(Nums, Prev1, Prev2).

rob_helper([], Prev1, _Prev2) ->
    Prev1;
rob_helper([H | T], Prev1, Prev2) ->
    Current = max(Prev1, Prev2 + H),
    rob_helper(T, Current, Prev1).
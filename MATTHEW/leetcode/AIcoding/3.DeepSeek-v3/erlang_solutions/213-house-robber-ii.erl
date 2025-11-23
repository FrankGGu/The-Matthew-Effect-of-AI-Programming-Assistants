-spec rob(Nums :: [integer()]) -> integer().
rob(Nums) ->
    case Nums of
        [] -> 0;
        [X] -> X;
        _ ->
            Max1 = rob_helper(lists:sublist(Nums, 1, length(Nums) - 1)),
            Max2 = rob_helper(lists:nthtail(1, Nums)),
            max(Max1, Max2)
    end.

-spec rob_helper(Nums :: [integer()]) -> integer().
rob_helper(Nums) ->
    rob_helper(Nums, 0, 0).

-spec rob_helper(Nums :: [integer()], Prev1 :: integer(), Prev2 :: integer()) -> integer().
rob_helper([], Prev1, _Prev2) ->
    Prev1;
rob_helper([H | T], Prev1, Prev2) ->
    rob_helper(T, max(Prev1, Prev2 + H), Prev1).
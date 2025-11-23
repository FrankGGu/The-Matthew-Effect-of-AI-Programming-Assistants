-spec rob(Nums :: [integer()]) -> integer().
rob([H|T]) when length([H|T]) == 1 -> H;
rob([H1, H2 | _]) -> max(H1, H2);
rob(Nums) ->
    rob_helper(tl(Nums), hd(Nums), 0, tl(Nums)).

-spec rob_helper(Remaining :: [integer()], Prev1 :: integer(), Prev2 :: integer(), All :: [integer()]) -> integer().
rob_helper([], Prev1, Prev2, _) -> Prev1;
rob_helper([H | T], Prev1, Prev2, All) ->
    rob_helper(T, max(Prev1, Prev2 + H), Prev1, All).

-spec rob(Nums :: [integer()]) -> integer().
rob(Nums) ->
    rob(Nums, 0, 0).

rob([], Prev1, Prev2) ->
    max(Prev1, Prev2);
rob([H | T], Prev1, Prev2) ->
    rob(T, Prev2, max(Prev1 + H, Prev2)).
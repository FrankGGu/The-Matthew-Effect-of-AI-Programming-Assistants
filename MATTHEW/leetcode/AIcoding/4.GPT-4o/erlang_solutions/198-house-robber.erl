-spec rob(Nums :: [integer()]) -> integer().
rob(Nums) ->
    rob(Nums, length(Nums), 0, 0).

rob([], _, Prev1, Prev2) -> Prev1;
rob([Head | Tail], 1, Prev1, Prev2) -> max(Prev1, Head);
rob([Head | Tail], N, Prev1, Prev2) when N > 1 ->
    rob(Tail, N - 1, max(Prev1, Head + Prev2), Prev1).

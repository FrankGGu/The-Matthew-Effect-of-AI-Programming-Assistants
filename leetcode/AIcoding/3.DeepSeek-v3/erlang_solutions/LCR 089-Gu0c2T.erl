-spec rob(Nums :: [integer()]) -> integer().
rob([]) -> 0;
rob([X]) -> X;
rob([X, Y | Rest]) ->
    rob_helper(Rest, X, max(X, Y)).

rob_helper([], Prev, Curr) -> Curr;
rob_helper([H | T], Prev, Curr) ->
    rob_helper(T, Curr, max(Curr, Prev + H)).
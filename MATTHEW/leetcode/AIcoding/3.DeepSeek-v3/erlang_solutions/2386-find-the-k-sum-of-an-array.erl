-spec k_sum(Nums :: [integer()], K :: integer()) -> integer().
k_sum(Nums, K) ->
    Sum = lists:sum([max(0, X) || X <- Nums]),
    AbsNums = lists:sort([abs(X) || X <- Nums]),
    Q = [{0, 1}],
    lists:nth(K, lists:sort([Sum - X || X <- bfs(Q, AbsNums, [])])).

bfs([], _, Res) -> Res;
bfs([{Sum, Index} | Rest], Nums, Res) ->
    case Index > length(Nums) of
        true -> bfs(Rest, Nums, Res);
        false ->
            NewSum = Sum + lists:nth(Index, Nums),
            NewRes = [NewSum | Res],
            NewQ = Rest ++ [{NewSum, Index + 1}, {Sum, Index + 1}],
            bfs(NewQ, Nums, NewRes)
    end.
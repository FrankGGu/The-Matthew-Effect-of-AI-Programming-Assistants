-spec put_marbles(Weights :: [integer()], K :: integer()) -> integer().
put_marbles(Weights, K) ->
    N = length(Weights),
    if 
        K == 1 orelse K == N -> 0;
        true ->
            Pairs = lists:zipwith(fun(X, Y) -> X + Y end, Weights, tl(Weights)),
            Sorted = lists:sort(Pairs),
            Len = length(Sorted),
            MaxSum = lists:sum(lists:sublist(Sorted, Len - K + 1, K - 1)),
            MinSum = lists:sum(lists:sublist(Sorted, 1, K - 1)),
            MaxSum - MinSum
    end.
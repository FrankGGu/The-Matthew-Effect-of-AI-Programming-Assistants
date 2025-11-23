-module(solution).
-export([min_subsequence/1]).

min_subsequence(Nums) ->
    Sorted = lists:sort(>=, Nums),
    Total = lists:sum(Sorted),
    {Subseq, _} = lists:foldl(fun(X, {Acc, Sum}) ->
        if
            Sum + X > Total - Sum ->
                {Acc ++ [X], Sum + X};
            true ->
                {Acc, Sum + X}
        end
    end, {[], 0}, Sorted),
    Subseq.
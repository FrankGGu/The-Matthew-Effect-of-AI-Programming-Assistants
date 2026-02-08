-spec maximum_sum_subsequence(Nums :: [integer()]) -> integer().
maximum_sum_subsequence(Nums) ->
    case Nums of
        [] -> 0;
        [X] -> X;
        [X, Y] -> max(X, Y);
        _ ->
            {Sum1, Sum2} = lists:foldl(fun(N, {Prev1, Prev2}) ->
                NewSum = max(Prev2 + N, Prev1),
                {NewSum, Prev1}
            end, {hd(Nums), 0}, tl(Nums)),
            max(Sum1, Sum2)
    end.
-spec x_sum_subarrays(Nums :: [integer()], K :: integer(), X :: integer()) -> integer().
x_sum_subarrays(Nums, K, X) ->
    Sums = lists:foldl(fun(N, Acc) ->
        case Acc of
            [] -> [N];
            [H|T] -> [H + N | [H|T]]
        end
    end, [], Nums),
    Len = length(Nums),
    if
        K > Len -> 0;
        true ->
            lists:foldl(fun(I, Sum) ->
                SubSum = lists:nth(I, Sums) - (if I > K -> lists:nth(I - K, Sums); true -> 0 end),
                if
                    SubSum >= X -> Sum + 1;
                    true -> Sum
                end
            end, 0, lists:seq(K, Len))
    end.
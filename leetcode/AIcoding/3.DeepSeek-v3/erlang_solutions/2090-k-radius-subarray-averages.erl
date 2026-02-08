-spec k_radius_averages(Nums :: [integer()], K :: integer()) -> [integer()].
k_radius_averages(Nums, K) ->
    N = length(Nums),
    if
        K =:= 0 -> Nums;
        K > N div 2 -> lists:duplicate(N, -1);
        true ->
            Prefix = prefix_sum(Nums),
            calculate_averages(Nums, Prefix, K, N)
    end.

prefix_sum(Nums) ->
    lists:foldl(fun(X, [H|T]) -> [H + X | [H|T]] end, [0], Nums).

calculate_averages(Nums, Prefix, K, N) ->
    lists:map(fun(I) ->
        if
            I - K < 1 orelse I + K > N -> -1;
            true ->
                Sum = lists:nth(N - (I - K - 1), Prefix) - lists:nth(N - (I + K), Prefix),
                Sum div (2 * K + 1)
        end
    end, lists:seq(1, N)).
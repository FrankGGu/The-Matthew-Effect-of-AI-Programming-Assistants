-spec longest_ones(Nums :: [integer()], K :: integer()) -> integer().
longest_ones(Nums, K) ->
    longest_ones(Nums, K, 0, 0, 0).

longest_ones([], _K, Left, Right, Max) ->
    max(Max, Right - Left);
longest_ones([1 | T], K, Left, Right, Max) ->
    longest_ones(T, K, Left, Right + 1, max(Max, Right + 1 - Left));
longest_ones([0 | T], K, Left, Right, Max) when K > 0 ->
    longest_ones(T, K - 1, Left, Right + 1, max(Max, Right + 1 - Left));
longest_ones([0 | _] = Nums, 0, Left, Right, Max) when Left < length(Nums) ->
    case lists:nth(Left + 1, Nums) of
        0 -> longest_ones(tl(Nums), 0, Left + 1, Left + 1, Max);
        1 -> longest_ones(tl(Nums), K, Left + 1, Right, Max)
    end;
longest_ones(_, _, _, _, Max) ->
    Max.
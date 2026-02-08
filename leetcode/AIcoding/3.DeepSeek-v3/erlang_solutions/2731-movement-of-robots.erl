-spec sum_distance(Nums :: [integer()], S :: unicode:unicode_binary(), D :: integer()) -> integer().
sum_distance(Nums, S, D) ->
    Mod = 1000000007,
    N = length(Nums),
    Positions = lists:sort([case lists:nth(I, S) of $L -> lists:nth(I, Nums) - D; $R -> lists:nth(I, Nums) + D end || I <- lists:seq(1, N)]),
    calculate_sum(Positions, 0, 0, Mod).

calculate_sum([], _, Sum, Mod) ->
    Sum rem Mod;
calculate_sum([H | T], I, Sum, Mod) ->
    NewSum = (Sum + (H * I - (length(T) * H))) rem Mod,
    calculate_sum(T, I + 1, NewSum, Mod).
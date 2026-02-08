-module(solution).
-export([stone_game_ii/1]).

stone_game_ii(Piles) ->
    N = length(Piles),
    DP = array:new([{size, N}, {default, array:new([{size, N + 1}, {default, 0}])}]),
    SuffixSums = lists:reverse(lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Piles)),
    {Result, _} = dfs(0, 1, DP, SuffixSums, N),
    Result.

dfs(I, M, DP, SuffixSums, N) when I >= N ->
    {0, DP};
dfs(I, M, DP, SuffixSums, N) ->
    case array:get(I, array:get(M, DP)) of
        0 ->
            MaxStones = 0,
            {NewDP, MaxStones1} = calc_max_stones(I, M, 1, MaxStones, DP, SuffixSums, N),
            NewDP1 = array:set(M, array:set(I, MaxStones1, array:get(M, NewDP)), NewDP),
            {MaxStones1, NewDP1};
        Cached ->
            {Cached, DP}
    end.

calc_max_stones(I, M, X, MaxStones, DP, SuffixSums, N) when X =< 2 * M, I + X - 1 < N ->
    {NextStones, NewDP} = dfs(I + X, max(M, X), DP, SuffixSums, N),
    CurrentStones = lists:nth(I + 1, SuffixSums) - NextStones,
    NewMaxStones = max(MaxStones, CurrentStones),
    calc_max_stones(I, M, X + 1, NewMaxStones, NewDP, SuffixSums, N);
calc_max_stones(_, _, _, MaxStones, DP, _, _) ->
    {DP, MaxStones}.
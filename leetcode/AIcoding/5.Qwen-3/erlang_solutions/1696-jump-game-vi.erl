-module(jump_game_vi).
-export([max_songs/2]).

max_songs(Nums, k) ->
    N = length(Nums),
    DP = array:new(N, {default, 0}),
    DP1 = array:set(0, lists:nth(1, Nums), DP),
    max_songs_helper(Nums, k, 1, DP1, N).

max_songs_helper(_, _, N, DP, _) when N == 0 ->
    array:get(0, DP);
max_songs_helper(Nums, K, I, DP, N) ->
    MaxVal = get_max(DP, I - 1, I - K),
    NewVal = MaxVal + lists:nth(I, Nums),
    DP1 = array:set(I, NewVal, DP),
    max_songs_helper(Nums, K, I + 1, DP1, N).

get_max(DP, Start, End) when Start < 0 ->
    0;
get_max(DP, Start, End) ->
    Max = array:get(Start, DP),
    get_max(DP, Start - 1, End, Max).

get_max(DP, Start, End, Acc) when Start < End ->
    Acc;
get_max(DP, Start, End, Acc) ->
    Current = array:get(Start, DP),
    NewAcc = if Current > Acc -> Current; true -> Acc end,
    get_max(DP, Start - 1, End, NewAcc).
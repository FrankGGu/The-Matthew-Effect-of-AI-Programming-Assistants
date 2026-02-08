-module(maximum_score_of_a_good_subarray).
-export([maximumScore/1]).

maximumScore(Nums) ->
    N = length(Nums),
    MaxScores = lists:seq(0, N-1),
    lists:foldl(fun(I, Acc) -> 
        {MinVal, _} = get_min_val(Nums, I, I),
        max(Acc, MinVal * (I - I + 1))
    end, 0, MaxScores).

get_min_val(_, L, R) when L < 0; R >= length(Nums) -> {0, 0};
get_min_val(Nums, L, R) ->
    Min = lists:min(lists:sublist(Nums, L+1, R-L+1)),
    {Min, L}.

maximumScore(Nums) ->
    N = length(Nums),
    Max = 0,
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    lists:foldl(fun(I, Acc) ->
        L = I,
        R = I,
        CurrentMin = lists:nth(I+1, Nums),
        while L >= 0 andalso R < N do
            if L == R -> ok;
               true -> CurrentMin = min(CurrentMin, lists:nth(L+1, Nums)), CurrentMin = min(CurrentMin, lists:nth(R+1, Nums))
            end,
            Acc = max(Acc, CurrentMin * (R - L + 1)),
            if L == 0 -> break;
               true -> L = L - 1
            end,
            if R == N-1 -> break;
               true -> R = R + 1
            end
        end,
        Acc
    end, 0, Left).
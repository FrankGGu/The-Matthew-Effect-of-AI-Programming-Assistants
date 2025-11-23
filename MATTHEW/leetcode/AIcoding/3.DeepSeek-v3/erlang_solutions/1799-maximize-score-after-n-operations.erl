-module(solution).
-export([max_score/1]).

max_score(Nums) ->
    N = length(Nums) div 2,
    Mem = maps:new(),
    {Result, _} = dfs(Nums, N, 0, Mem),
    Result.

dfs([], 0, Mask, _) -> {0, Mask};
dfs(Nums, K, Mask, Mem) ->
    case maps:get(Mask, Mem, undefined) of
        undefined ->
            MaxScore = 0,
            NewMem = Mem;
        {Score, NewMask} ->
            {Score, NewMask}
    end,
    case maps:get(Mask, Mem, undefined) of
        undefined ->
            MaxScore = 0,
            NewMem = Mem,
            {NewMaxScore, NewMask} = try_all_pairs(Nums, K, Mask, NewMem),
            {NewMaxScore, NewMask};
        {Score, NewMask} ->
            {Score, NewMask}
    end.

try_all_pairs(Nums, K, Mask, Mem) ->
    MaxScore = 0,
    NewMask = Mask,
    try_all_pairs(Nums, K, Mask, 0, length(Nums) - 1, MaxScore, NewMask, Mem).

try_all_pairs(_, 0, Mask, _, _, MaxScore, NewMask, Mem) ->
    {MaxScore, NewMask};
try_all_pairs(Nums, K, Mask, I, J, MaxScore, NewMask, Mem) when I >= J ->
    try_all_pairs(Nums, K, Mask, 0, J - 1, MaxScore, NewMask, Mem);
try_all_pairs(Nums, K, Mask, I, J, MaxScore, NewMask, Mem) ->
    case ((Mask bsr I) band 1) =:= 0 andalso ((Mask bsr J) band 1) =:= 0 of
        true ->
            NewMask1 = Mask bor (1 bsl I) bor (1 bsl J),
            G = gcd(lists:nth(I + 1, Nums), lists:nth(J + 1, Nums)),
            {Score, _} = dfs(Nums, K - 1, NewMask1, Mem),
            CurrentScore = K * G + Score,
            if
                CurrentScore > MaxScore ->
                    NewMaxScore = CurrentScore,
                    NewNewMask = NewMask1;
                true ->
                    NewMaxScore = MaxScore,
                    NewNewMask = NewMask
            end,
            try_all_pairs(Nums, K, Mask, I + 1, J, NewMaxScore, NewNewMask, Mem);
        false ->
            try_all_pairs(Nums, K, Mask, I + 1, J, MaxScore, NewMask, Mem)
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
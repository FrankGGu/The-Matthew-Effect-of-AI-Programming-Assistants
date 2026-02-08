-module(good_subsets).
-export([num_good_subsets/1]).

num_good_subsets(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    Primes = [2,3,5,7,11,13,17,19,23,29,31],
    {Result, _} = dfs(Count, Primes, 0, 0),
    Result.

dfs(_Count, [], _, Acc) ->
    {Acc, 0};
dfs(Count, [P | Ps], Mask, Acc) ->
    case dict:is_key(P, Count) of
        true ->
            Cnt = dict:fetch(P, Count),
            NewMask = Mask bor (1 bsl (P-1)),
            {Res, _} = dfs(Count, Ps, NewMask, Acc),
            {NewRes, _} = dfs(Count, Ps, Mask, Acc + Cnt * Res),
            {NewRes, 0};
        false ->
            dfs(Count, Ps, Mask, Acc)
    end.
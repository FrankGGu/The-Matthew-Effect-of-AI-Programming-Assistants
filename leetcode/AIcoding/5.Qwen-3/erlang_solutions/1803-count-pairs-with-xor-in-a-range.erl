-module(solution).
-export([count_pairs/2]).

count_pairs(Nums, [L, R]) ->
    N = length(Nums),
    Count = 0,
    count_pairs(Nums, L, R, 0, N-1, Count).

count_pairs(_, _, _, I, _, Count) when I >= length(Nums) -> Count;
count_pairs(Nums, L, R, I, J, Count) when J < I -> count_pairs(Nums, L, R, I+1, length(Nums)-1, Count);
count_pairs(Nums, L, R, I, J, Count) ->
    Xor = lists:nth(I+1, Nums) bxor lists:nth(J+1, Nums),
    case Xor >= L andalso Xor =< R of
        true -> count_pairs(Nums, L, R, I, J-1, Count + 1);
        false -> count_pairs(Nums, L, R, I, J-1, Count)
    end.
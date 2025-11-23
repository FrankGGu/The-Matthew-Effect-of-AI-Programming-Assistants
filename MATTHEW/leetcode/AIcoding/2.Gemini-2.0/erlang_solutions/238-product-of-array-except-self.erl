-module(product_except_self).
-export([product_except_self/1]).

product_except_self(Nums) ->
    N = length(Nums),
    {Left, Right} = lists:foldl(
        fun(Num, {AccLeft, AccRight}) ->
            {AccLeft ++ [case AccLeft of [] -> 1; [Last | _] -> Last * element(Num,1) end],
             [case AccRight of [] -> 1; [Last | _] -> Last * element(Num,2) end] ++ AccRight}
        end, {[], []}, lists:zip(Nums, lists:reverse(Nums))),
    lists:map(fun(Index) ->
        case Index of
            1 -> lists:nth(2, Right);
            N -> lists:nth(N-1, Left);
            _ -> lists:nth(Index-1, Left) * lists:nth(N-Index+1, Right)
        end
    end, lists:seq(1,N)).
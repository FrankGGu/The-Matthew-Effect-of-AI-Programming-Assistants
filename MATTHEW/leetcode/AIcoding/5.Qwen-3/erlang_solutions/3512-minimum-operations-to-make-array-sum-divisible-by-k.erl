-module(solution).
-export([min_ops/1]).

min_ops(Nums) ->
    K = 2,
    Sum = lists:sum(Nums),
    Rem = Sum rem K,
    if
        Rem == 0 -> 0;
        true ->
            Count = maps:fold(
                fun(_, V, Acc) ->
                    case (V rem K) == Rem of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end,
                0,
                maps:from_list(lists:zip(Nums, lists:seq(1, length(Nums))))
            ),
            Count
    end.
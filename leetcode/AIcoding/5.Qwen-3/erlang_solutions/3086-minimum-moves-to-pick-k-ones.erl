-module(minimum_moves_to_pick_k_ones).
-export([minMovesToPickKOnes/1]).

minMovesToPickKOnes(Nums) ->
    K = 1,
    N = length(Nums),
    Indices = lists:filter(fun(I) -> lists:nth(I+1, Nums) == 1 end, lists:seq(0, N-1)),
    if
        length(Indices) < K -> -1;
        true ->
            Len = length(Indices),
            Min = lists:foldl(fun(I, Acc) ->
                Start = I,
                End = I + K - 1,
                if
                    End >= Len -> Acc;
                    true ->
                        Mid = (Start + End) div 2,
                        Total = 0,
                        lists:foldl(fun(J, T) ->
                            T + abs(lists:nth(Mid, Indices) - lists:nth(J, Indices))
                        end, Total, lists:seq(Start, End))
                end
            end, 1000000000, lists:seq(0, Len - K)),

            Min
    end.
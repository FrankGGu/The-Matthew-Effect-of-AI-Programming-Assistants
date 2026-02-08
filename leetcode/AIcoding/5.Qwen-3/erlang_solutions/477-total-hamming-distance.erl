-module(total_hamming_distance).
-export([totalHammingDistance/1]).

totalHammingDistance(Nums) ->
    lists:foldl(fun(N, Acc) -> 
        lists:foldl(fun(I, A) -> 
            case (N band (1 bsl I)) of
                0 -> A;
                _ -> A + 1
            end
        end, Acc, lists:seq(0, 30))
    end, 0, Nums).

countSetBits(Num) ->
    lists:foldl(fun(I, Acc) -> 
        case (Num band (1 bsl I)) of
            0 -> Acc;
            _ -> Acc + 1
        end
    end, 0, lists:seq(0, 30)).
-module(solution).
-export([count_partitions/1]).

count_partitions(Nums) ->
    TotalSum = lists:sum(Nums),
    case TotalSum rem 2 of
        1 -> 0;
        0 -> 
            Half = TotalSum div 2,
            DP = array:new([{size, Half + 1}, {default, 0}]),
            DP1 = array:set(0, 1, DP),
            lists:foldl(fun(Num, Acc) ->
                lists:foldl(fun(J, DPAcc) ->
                    case J >= Num of
                        true -> 
                            Val = array:get(J - Num, DPAcc),
                            array:set(J, (array:get(J, DPAcc) + Val, DPAcc);
                        false -> DPAcc
                    end
                end, Acc, lists:seq(Half, 0, -1))
            end, DP1, Nums),
            (array:get(Half, lists:foldl(fun(Num, Acc) ->
                lists:foldl(fun(J, DPAcc) ->
                    case J >= Num of
                        true -> 
                            Val = array:get(J - Num, DPAcc),
                            array:set(J, (array:get(J, DPAcc) + Val, DPAcc);
                        false -> DPAcc
                    end
                end, Acc, lists:seq(Half, 0, -1))
            end, DP1, Nums))) div 2
    end.
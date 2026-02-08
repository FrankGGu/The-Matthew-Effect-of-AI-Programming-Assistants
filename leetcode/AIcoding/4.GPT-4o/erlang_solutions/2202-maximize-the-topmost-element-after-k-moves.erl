-module(solution).
-export([maximum_top/2]).

maximum_top(Nums, K) ->
    case length(Nums) of
        0 -> 0;
        N when K == 0 -> hd(Nums);
        N when K >= N -> lists:max(Nums);
        _ ->
            Max = lists:max(lists:sublist(Nums, 1, K + 1)),
            Max
    end.
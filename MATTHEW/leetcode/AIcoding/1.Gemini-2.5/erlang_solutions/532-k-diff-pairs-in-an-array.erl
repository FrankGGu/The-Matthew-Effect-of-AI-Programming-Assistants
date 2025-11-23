-module(solution).
-export([findPairs/2]).

findPairs(Nums, K) when K == 0 ->
    Counts = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(C) -> C + 1 end, 1, Acc) end, #{}, Nums),
    maps:fold(fun(_N, C, Acc) -> if C >= 2 -> Acc + 1; true -> Acc end end, 0, Counts);
findPairs(Nums, K) when K > 0 ->
    UniqueNumsSet = gb_sets:from_list(Nums),
    gb_sets:fold(fun(N, Acc) ->
                     if gb_sets:is_member(N + K, UniqueNumsSet) -> Acc + 1;
                        true -> Acc
                     end
                 end, 0, UniqueNumsSet).
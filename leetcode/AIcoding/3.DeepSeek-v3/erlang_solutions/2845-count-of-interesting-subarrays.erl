-module(solution).
-export([count_interesting_subarrays/3]).

count_interesting_subarrays(Nums, Mod, K) ->
    Prefix = [0],
    Sum = 0,
    CountMap = #{0 => 1},
    lists:foldl(fun(Num, {PrefixSum, CMap, Res}) ->
        NewSum = (PrefixSum + if Num rem Mod == K -> 1; true -> 0 end) rem Mod,
        Needed = (NewSum - K) rem Mod,
        case maps:get(Needed, CMap, 0) of
            Val when is_integer(Val) ->
                NewRes = Res + Val,
                NewCMap = maps:put(NewSum, maps:get(NewSum, CMap, 0) + 1, CMap),
                {NewSum, NewCMap, NewRes};
            _ ->
                {NewSum, CMap, Res}
        end
    end, {Sum, CountMap, 0}, Nums),
    element(3, lists:foldl(fun(Num, {PrefixSum, CMap, Res}) ->
        NewSum = (PrefixSum + if Num rem Mod == K -> 1; true -> 0 end) rem Mod,
        Needed = (NewSum - K) rem Mod,
        case maps:get(Needed, CMap, 0) of
            Val when is_integer(Val) ->
                NewRes = Res + Val,
                NewCMap = maps:put(NewSum, maps:get(NewSum, CMap, 0) + 1, CMap),
                {NewSum, NewCMap, NewRes};
            _ ->
                {NewSum, CMap, Res}
        end
    end, {Sum, CountMap, 0}, Nums)).
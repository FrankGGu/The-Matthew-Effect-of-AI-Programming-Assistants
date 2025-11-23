-module(solution).
-export([countMaxOrSubsets/1]).

countMaxOrSubsets(Nums) ->
    MaxORValue = lists:foldl(fun(X, Acc) -> X bor Acc end, 0, Nums),
    count_subsets_recursive(Nums, 0, MaxORValue).

count_subsets_recursive([], CurrentOR, TargetOR) ->
    case CurrentOR == TargetOR of
        true -> 1;
        false -> 0
    end;
count_subsets_recursive([Head | Tail], CurrentOR, TargetOR) ->
    CountWithoutHead = count_subsets_recursive(Tail, CurrentOR, TargetOR),
    CountWithHead = count_subsets_recursive(Tail, CurrentOR bor Head, TargetOR),
    CountWithoutHead + CountWithHead.
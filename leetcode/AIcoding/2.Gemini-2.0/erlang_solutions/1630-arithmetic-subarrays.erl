-module(arithmetic_subarrays).
-export([checkArithmeticSubarrays/3]).

checkArithmeticSubarrays(Nums, L, R) ->
    lists:map(fun(I) -> isArithmetic(lists:sublist(Nums, lists:nth(I, L), lists:nth(I, R) - lists:nth(I, L) + 1)) end, lists:seq(1, length(L))).

isArithmetic(Subarray) ->
    Sorted = lists:sort(Subarray),
    case length(Sorted) < 3 of
        true -> true;
        false ->
            Diff = lists:nth(2, Sorted) - lists:nth(1, Sorted),
            lists:all(fun(I) ->
                case I + 1 > length(Sorted) of
                    true -> true;
                    false -> lists:nth(I + 1, Sorted) - lists:nth(I, Sorted) == Diff
                end
            end, lists:seq(1, length(Sorted) - 1))
    end.
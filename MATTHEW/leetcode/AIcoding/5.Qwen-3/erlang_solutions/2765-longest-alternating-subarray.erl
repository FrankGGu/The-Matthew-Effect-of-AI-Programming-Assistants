-module(longest_alternating_subarray).
-export([longestAlternatingSubarray/1]).

longestAlternatingSubarray(Nums) ->
    N = length(Nums),
    if
        N == 0 -> 0;
        true -> helper(Nums, 1, 1, 1)
    end.

helper(_, _, _, Max) -> Max;
helper(Nums, I, Len, Max) ->
    if
        I >= length(Nums) -> Max;
        true ->
            Next = I + 1,
            Current = lists:nth(I, Nums),
            NextVal = lists:nth(Next, Nums),
            if
                (Current > NextVal andalso Len == 1) orelse (Current < NextVal andalso Len == 1) ->
                    helper(Nums, Next, 2, max(Max, 2));
                (Current > NextVal andalso Len rem 2 == 0) orelse (Current < NextVal andalso Len rem 2 == 0) ->
                    helper(Nums, Next, Len + 1, max(Max, Len + 1));
                true ->
                    helper(Nums, Next, 1, Max)
            end
    end.
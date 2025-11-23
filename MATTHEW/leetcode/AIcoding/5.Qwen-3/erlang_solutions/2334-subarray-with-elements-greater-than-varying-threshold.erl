-module(solution).
-export([findSubarray/2]).

findSubarray(Nums, Threshold) ->
    N = length(Nums),
    M = length(Threshold),
    findSubarray(Nums, Threshold, 0, N - 1, 0, M - 1).

findSubarray(_, _, L, R, _, _) when L > R -> [];
findSubarray(Nums, Threshold, L, R, Tl, Tr) ->
    case check(Nums, Threshold, L, R, Tl, Tr) of
        true -> [L, R];
        false ->
            if
                L < R -> findSubarray(Nums, Threshold, L + 1, R, Tl, Tr);
                true -> []
            end
    end.

check(_, _, _, _, Tl, Tr) when Tl > Tr -> true;
check(Nums, Threshold, L, R, Tl, Tr) ->
    case Nums!!L >= Threshold!!Tl of
        true -> check(Nums, Threshold, L + 1, R, Tl + 1, Tr);
        false -> false
    end.
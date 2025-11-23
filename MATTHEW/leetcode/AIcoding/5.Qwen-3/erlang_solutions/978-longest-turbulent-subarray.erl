-module(longest_turbulent_subarray).
-export([max_turbulence_size/1]).

max_turbulence_size(Nums) ->
    len = length(Nums),
    if
        len < 2 -> len;
        true -> helper(Nums, 0, 1, 0, 0)
    end.

helper(_, _, _, Max, _), Max >= 1 -> Max;
helper(Nums, I, J, Max, Count) ->
    case J of
        Len when Len =:= length(Nums) -> Max;
        _ ->
            A = lists:nth(I, Nums),
            B = lists:nth(J, Nums),
            C = lists:nth(J+1, Nums),
            case (B > A andalso B > C) orelse (B < A andalso B < C) of
                true -> helper(Nums, I+1, J+1, max(Max, Count+2), Count+2);
                false -> helper(Nums, I+1, J+1, Max, 0)
            end
    end.
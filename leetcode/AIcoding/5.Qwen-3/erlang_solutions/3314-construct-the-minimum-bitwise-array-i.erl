-module(solution).
-export([min_bitwise_array/1]).

min_bitwise_array(Nums) ->
    N = length(Nums),
    List = lists:seq(1, N),
    lists:sort(fun(A, B) -> 
        case (lists:nth(A, Nums) band lists:nth(B, Nums)) < (lists:nth(B, Nums) band lists:nth(A, Nums)) of
            true -> true;
            false -> false
        end
    end, List).
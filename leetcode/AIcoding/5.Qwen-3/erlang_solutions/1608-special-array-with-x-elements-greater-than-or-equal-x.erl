-module(special_array).
-export([special_array/1]).

special_array(Nums) ->
    N = length(Nums),
    lists:foldl(fun(X, Acc) ->
        case X >= N of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Nums).
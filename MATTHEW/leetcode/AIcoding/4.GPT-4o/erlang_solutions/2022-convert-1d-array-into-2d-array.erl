-module(solution).
-export([reshape/2]).

reshape(Nums, r) ->
    N = length(Nums),
    C = div(N, r),
    Reshape = lists:foldl(fun(X, Acc) -> 
        case Acc of 
            [] -> [[X]]; 
            [H|T] -> if 
                        length(H) < C -> [[X | H] | T]; 
                        true -> [[X] | Acc] 
                     end 
        end 
    end, [], Num),
    lists:reverse(Reshape).
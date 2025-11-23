-module(solution).
-export([num_subseqs_to_sum/2]).

num_subseqs_to_sum(Nums, target) ->
    lists:foldl(fun(N, Acc) -> 
        case N of
            X when X > target -> Acc;
            _ -> 
                lists:foldl(fun(Y, A) -> 
                    if Y + X <= target -> 
                        A + 1;
                    true -> 
                        A
                    end
                end, Acc, Nums)
        end
    end, 0, Nums).
-module(solution).
-export([num_good_subsets/1]).

num_good_subsets(Numbers) ->
    F = fun(X) -> 
            lists:foldl(fun(Y, Acc) -> Acc * (Y + 1) end, 1, X)
        end,

    Count = lists:foldl(fun(X, Acc) -> 
                            if 
                                X > 0 -> Acc + 1; 
                                true -> Acc 
                            end 
                        end, 0, Numbers),

    Counts = lists:foldl(fun(X, Acc) -> 
                            if 
                                element(1, X) > 0 -> 
                                    [{element(1, X) - 1, element(2, X) + 1} | Acc];
                                true -> Acc 
                            end 
                        end, [], lists:foldl(fun(X, Acc) -> 
                                                [{X, 1} | Acc] 
                                            end, [], lists:usort(Numbers))),

    F(Counts) * (math:pow(2, Count) - 1).
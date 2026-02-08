-module(solution).
-export([increasing_triplet/1]).

increasing_triplet(Nums) ->
    case length(Nums) of
        L when L < 3 -> false;
        _ -> 
            First = 2147483647,
            Second = 2147483647,
            lists:foldl(fun(N, {F, S}) ->
                            if N =< F -> {N, S};
                               N =< S -> {F, N};
                               true -> true
                            end
                        end, {First, Second}, Nums)
    end.
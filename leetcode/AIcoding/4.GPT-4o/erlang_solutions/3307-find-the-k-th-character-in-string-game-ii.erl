-module(solution).
-export([find_kth_character/2]).

find_kth_character(S, K) ->
    find_kth_character(S, K, 1).

find_kth_character(S, K, Count) when Count > K -> 
    hd(S);
find_kth_character(S, K, Count) ->
    case lists:foldl(fun(X, {Acc, N}) -> 
            if 
                N >= K -> {Acc, N}; 
                true -> {Acc ++ [X, X], N + 2} 
            end 
        end, {[], 0}, S) of
        {Res, N} -> find_kth_character(Res, K, Count + 1)
    end.
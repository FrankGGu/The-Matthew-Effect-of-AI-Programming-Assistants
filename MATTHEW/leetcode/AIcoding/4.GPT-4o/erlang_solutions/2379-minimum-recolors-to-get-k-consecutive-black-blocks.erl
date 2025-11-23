-module(solution).
-export([minimum_recolors/2]).

minimum_recolors(Blocks, K) ->
    MinRecolors = minimum_recolors_helper(Blocks, K, length(Blocks)),
    MinRecolors.

minimum_recolors_helper(Blocks, K, N) when K > N -> 
    -1;
minimum_recolors_helper(Blocks, K, N) ->
    BlackCount = lists:foldl(fun(X, Acc) -> 
        if X =:= $B -> Acc + 1; 
           true -> Acc 
        end 
    end, 0, lists:sublist(Blocks, K)),
    MinRecolors = K - BlackCount,
    if N - K > 0 -> 
        MinRecolorsNext = minimum_recolors_helper(lists:tl(Blocks), K, N - 1),
        min(MinRecolors, MinRecolorsNext);
        true -> 
            MinRecolors
    end.

min(A, B) when A < B -> A;
min(_, B) -> B.
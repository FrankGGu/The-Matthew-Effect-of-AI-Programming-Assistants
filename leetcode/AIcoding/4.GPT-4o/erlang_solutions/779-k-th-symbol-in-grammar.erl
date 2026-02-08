-module(solution).
-export([kthSymbol/2]).

kthSymbol(N, K) when N > 0, K > 0 ->
    kth_helper(N, K).

kth_helper(1, 1) -> 0;
kth_helper(N, K) ->
    ParentK = (K + 1) div 2,
    ParentSymbol = kth_helper(N - 1, ParentK),
    if 
        K rem 2 =:= 0 -> 
            if ParentSymbol =:= 0 -> 1; 
               true -> 0 
            end;
        true -> ParentSymbol 
    end.
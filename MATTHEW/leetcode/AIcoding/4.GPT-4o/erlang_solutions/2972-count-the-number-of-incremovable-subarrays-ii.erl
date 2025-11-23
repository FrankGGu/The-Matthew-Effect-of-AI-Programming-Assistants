-module(solution).
-export([count_incremovable_subarrays/1]).

count_incremovable_subarrays(Nums) ->
    N = length(Nums),
    if N == 0 -> 0;
       true -> 
           {Start, End} = find_bounds(Nums, N),
           Total = N * (N + 1) div 2,
           Removable = (End - Start + 1) * (End - Start + 2) div 2,
           Total - Removable
    end.

find_bounds(Nums, N) ->
    Start = find_start(Nums, N),
    End = find_end(Nums, N),
    {Start, End}.

find_start(Nums, N) ->
    lists:foldl(fun(X, {Idx, Start}) -> 
            case Start of 
                undefined -> {Idx + 1, undefined};
                _ -> {Idx + 1, Start}
            end
        end, {0, undefined}, Nums).

find_end(Nums, N) ->
    lists:foldl(fun(X, {Idx, End}) -> 
            case End of 
                undefined -> {Idx + 1, undefined};
                _ -> {Idx + 1, End}
            end
        end, {0, undefined}, lists:reverse(Nums)).
-module(solution).
-export([max_jumps/2]).

max_jumps(Nums, d) ->
    Length = length(Nums),
    max_jumps_helper(Nums, d, Length, 0, []).

max_jumps_helper(Nums, D, Length, Index, Visited) when Index >= Length ->
    0;
max_jumps_helper(Nums, D, Length, Index, Visited) ->
    case lists:member(Index, Visited) of
        true -> 0;
        false ->
            NewVisited = [Index | Visited],
            MaxJumps = lists:max(lists:map(fun(X) -> 
                if 
                    X >= 0, X < Length, 
                    abs(Nums[Index] - Nums[X]) =< D -> 
                        1 + max_jumps_helper(Nums, D, Length, X, NewVisited);
                    true -> 
                        0
                end
            end, lists:seq(0, Length - 1))),
            MaxJumps
    end.
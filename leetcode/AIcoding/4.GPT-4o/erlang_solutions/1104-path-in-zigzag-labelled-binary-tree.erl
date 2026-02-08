-module(solution).
-export([zigzag_path/1]).

zigzag_path(N) when N > 0 ->
    Depth = trunc(log2(N + 1)),
    Path = zigzag_path_helper(N, Depth, 1, []),
    lists:reverse(Path).

zigzag_path_helper(N, 0, Value, Acc) ->
    [Value | Acc];
zigzag_path_helper(N, Depth, Value, Acc) ->
    NextDepth = Depth - 1,
    NextValue = if 
        Depth rem 2 =:= 0 -> 
            2 * ((2^(Depth + 1) - 1) - (Value - 1) div 2);
        true -> 
            2 * ((2^(Depth + 1) - 1) div 2 + (Value - 1) div 2)
    end,
    zigzag_path_helper(N, NextDepth, NextValue, [Value | Acc]).
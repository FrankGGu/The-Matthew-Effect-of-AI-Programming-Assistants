-module(solution).
-export([num_moves_stones/3]).

num_moves_stones(Start, End, Target) ->
    MinMoves = case Start of 
                    A when A =< Target -> Target - Start;
                    _ -> 0
                end + 
                case End of 
                    B when B =< Target -> Target - End;
                    _ -> 0
                end,
    MaxMoves = abs(Start - End) - 1,
    {MinMoves, MaxMoves}.
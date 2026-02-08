-module(solution).
-export([min_swaps/2]).

min_swaps(Binary, K) ->
    Ones = lists:filter(fun(X) -> X =:= 1 end, Binary),
    If K > length(Ones) -> 0;
    Positions = lists:foldl(fun(P, Acc) -> 
        case lists:nth(P + 1, Binary) of 
            1 -> [P | Acc]; 
            _ -> Acc 
        end 
    end, [], lists:seq(0, length(Binary) - 1)),
    K_positions = lists:sublist(Positions, K),
    Min_swaps(K_positions, 0).

Min_swaps(Positions, Swaps) ->
    case Positions of
        [] -> Swaps;
        [H | T] -> 
            New_Swaps = lists:foldl(fun(P, Acc) -> 
                Acc + (P - H) 
            end, Swaps, T),
            Min_swaps(T, New_Swaps)
    end.
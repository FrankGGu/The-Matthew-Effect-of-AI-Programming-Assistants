-module(solution).
-export([minimum_swaps/2]).

minimum_swaps(S1, S2) ->
    case length(S1) =:= length(S2) of
        false -> -1;
        true ->
            Count = lists:foldl(fun({C1, C2}, Acc) -> 
                case {C1, C2} of 
                    {_, _} when C1 =:= C2 -> Acc; 
                    {X, Y} -> Acc + 1 
                end 
            end, 0, lists:zip(lists:seq(1, length(S1)), lists:seq(1, length(S2))),
            [{lists:nth(I, S1), lists:nth(I, S2)} || I <- lists:seq(1, length(S1))]),
            if 
                Count rem 2 =:= 0 -> Count div 2; 
                true -> -1 
            end
    end.
-module(solution).
-export([maxElegance/2]).

maxElegance(N, K) ->
    lists:foldl(fun({x, y}, Acc) -> 
        case Acc of
            {Max, Set} when length(Set) < K -> 
                {Max + y, [x | Set]};
            {Max, Set} when length(Set) = K -> 
                {Max + y - hd(Set), tl(Set) ++ [x]};
            _ -> 
                Acc
        end
    end, {0, []}, lists:sort(fun({_, A}, {_, B}) -> A > B end, N).
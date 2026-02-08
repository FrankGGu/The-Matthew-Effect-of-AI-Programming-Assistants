-module(solution).
-export([minimum_swaps/1]).

minimum_swaps(S) ->
    N = length(S),
    {Left, Right} = lists:foldl(fun (C, {L, R}) ->
        case C of
            $\{ -> {L + 1, R};
            $\} -> {L, R + 1}
        end
    end, {0, 0}, string:to_list(S)),
    AbsDiff = abs(Left - Right),
    (AbsDiff rem 2 =:= 0) -> AbsDiff div 2; 
    -1.
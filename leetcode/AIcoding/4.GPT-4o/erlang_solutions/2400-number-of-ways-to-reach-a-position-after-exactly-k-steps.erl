-module(solution).
-export([number_of_ways/3]).

number_of_ways(N, K, P) ->
    number_of_ways_helper(N, K, P, 0, 0).

number_of_ways_helper(_, 0, P, _, Count) when P == 0 -> 
    Count + 1;
number_of_ways_helper(N, K, P, Position, Count) when K > 0 ->
    Count1 = if 
        Position + 1 =< N -> 
            number_of_ways_helper(N, K - 1, P - 1, Position + 1, Count) 
        else 
            Count 
    end,
    Count2 = if 
        Position - 1 >= 0 -> 
            number_of_ways_helper(N, K - 1, P - 1, Position - 1, Count1) 
        else 
            Count1 
    end,
    Count3 = if 
        Position =< N -> 
            number_of_ways_helper(N, K - 1, P - 1, Position, Count2) 
        else 
            Count2 
    end,
    Count3;
number_of_ways_helper(_, _, _, _, Count) -> 
    Count.
-module(solution).
-export([numOfWays/1]).

numOfWays(N) ->
    Count = fun(X) when X > 0 ->
        if 
            X * X > N -> 0;
            true -> 
                if 
                    N rem X =:= 0 -> 1 + Count(X + 1);
                    true -> Count(X + 1)
                end
        end
    end,
    Count(1).
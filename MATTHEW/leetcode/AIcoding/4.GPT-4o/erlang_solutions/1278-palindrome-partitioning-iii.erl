-module(solution).
-export([palindrome_partitioning/3]).

palindrome_partitioning(S, K, N) ->
    Length = length(S),
    DP = lists:duplicate(Length + 1, lists:duplicate(Length + 1, 0)),
    Cost = lists:duplicate(Length + 1, lists:duplicate(Length + 1, 0)),
    InitCost = fun(I, J) ->
        if 
            I >= J -> 0;
            true -> 
                if 
                    lists:nth(I + 1, S) =:= lists:nth(J + 1, S) -> 
                        Cost(I + 1, J - 1);
                    true -> 
                        1 + Cost(I + 1, J - 1)
                end
        end
    end,
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) ->
            Cost(I, J) = InitCost(I, J)
        end, lists:seq(I, Length))
    end, lists:seq(0, Length)),
    lists:foreach(fun(I) ->
        DP(0, I) = 0
    end, lists:seq(0, Length)),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if 
                J > 0 -> 
                    DP(J, I) = lists:min([DP(J - 1, X) + Cost(X + 1, I) || X <- lists:seq(J - 1, I)]);
                true -> 
                    DP(J, I) = 0
            end
        end, lists:seq(J, Length))
    end, lists:seq(0, K)),
    DP(K, Length - 1).
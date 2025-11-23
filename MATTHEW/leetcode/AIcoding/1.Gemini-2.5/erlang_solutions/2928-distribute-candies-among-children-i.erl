-module(solution).
-export([distributeCandies/2]).

distributeCandies(Candies, MaxCandies) ->
    Count = 0,
    lists:foldl(fun(C1, Acc1) ->
        lists:foldl(fun(C2, Acc2) ->
            C3 = Candies - C1 - C2,
            if
                C3 >= 0 andalso C3 =< MaxCandies ->
                    Acc2 + 1;
                true ->
                    Acc2
            end
        end, Acc1, lists:seq(0, min(Candies - C1, MaxCandies)))
    end, Count, lists:seq(0, min(Candies, MaxCandies))).
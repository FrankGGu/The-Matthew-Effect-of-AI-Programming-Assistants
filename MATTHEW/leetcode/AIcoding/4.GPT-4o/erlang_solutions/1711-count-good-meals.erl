-module(solution).
-export([count_good_meals/1]).

count_good_meals(Dishes) ->
    N = length(Dishes),
    Counts = lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc2) -> 
            case (X + Y) rem 1_000_000_007 of
                0 -> Acc2;
                _ -> Acc2 + 1
            end
        end, Acc, Acc) 
    end, 0, Dishes),
    Counts rem 1_000_000_007.
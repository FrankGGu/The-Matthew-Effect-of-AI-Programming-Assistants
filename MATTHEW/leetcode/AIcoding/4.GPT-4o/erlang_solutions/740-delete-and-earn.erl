-module(solution).
-export([delete_and_earn/1]).

delete_and_earn(Numbers) ->
    Max = lists:max(Numbers),
    Points = lists:foldl(fun(X, Acc) -> lists:duplicate(X, 1) ++ Acc end, lists:duplicate(Max + 1, 0), Numbers),
    Earn = lists:foldl(fun(X, Acc) -> Acc + elem(X, Points) end, 0, lists:seq(0, Max)),
    delete_and_earn_helper(Points, 0, 0, 0).

delete_and_earn_helper([], Prev1, Prev2, Max) ->
    Max;
delete_and_earn_helper([H | T], Prev1, Prev2, Max) ->
    NewMax = max(Prev2 + H, Prev1),
    delete_and_earn_helper(T, NewMax, Prev1, NewMax).
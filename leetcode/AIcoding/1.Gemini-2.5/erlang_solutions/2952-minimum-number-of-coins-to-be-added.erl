-module(solution).
-export([min_coins_to_add/2]).

min_coins_to_add(Coins, Target) ->
    SortedCoins = lists:sort(Coins),
    solve(SortedCoins, Target, 0, 0).

solve(_Coins, Target, AddedCoins, ReachableSum) when ReachableSum >= Target ->
    AddedCoins;
solve([], Target, AddedCoins, ReachableSum) ->
    solve([], Target, AddedCoins + 1, ReachableSum + (ReachableSum + 1));
solve([C|Rest], Target, AddedCoins, ReachableSum) when C =< ReachableSum + 1 ->
    solve(Rest, Target, AddedCoins, ReachableSum + C);
solve(Coins, Target, AddedCoins, ReachableSum) ->
    solve(Coins, Target, AddedCoins + 1, ReachableSum + (ReachableSum + 1)).
-module(solution).
-export([collect_max_points/2]).

collect_max_points(Tree, Coins) ->
    MaxPoints = collect(Tree, Coins, 0, 0),
    MaxPoints.

collect({nil, nil}, Coins, Acc, _TotalCoins) ->
    Acc;
collect({Node, Left, Right}, Coins, Acc, TotalCoins) ->
    NewAcc = Acc + element(Node, Coins),
    NewTotalCoins = TotalCoins + element(Node, Coins),
    MaxLeft = collect(Left, Coins, NewAcc, NewTotalCoins),
    MaxRight = collect(Right, Coins, NewAcc, NewTotalCoins),
    max(MaxLeft, MaxRight).
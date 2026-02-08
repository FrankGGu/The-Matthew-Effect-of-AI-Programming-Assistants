-module(solution).
-export([best_poker_hand/1]).

best_poker_hand(Hands) ->
    Counts = lists:foldl(fun(X, Acc) -> lists:map(fun(Y) -> if Y == X -> Y; true -> 0 end end, Acc) ++ [X] end, [], Hands),
    MaxCount = lists:max(Counts),
    case MaxCount of
        4 -> "Four of a Kind";
        3 -> if lists:any(fun(X) -> X == 2 end, Counts) -> "Full House"; true -> "Three of a Kind" end;
        2 -> if lists:any(fun(X) -> X == 2 end, Counts) -> "Two Pair"; true -> "One Pair" end;
        _ -> "High Card"
    end.
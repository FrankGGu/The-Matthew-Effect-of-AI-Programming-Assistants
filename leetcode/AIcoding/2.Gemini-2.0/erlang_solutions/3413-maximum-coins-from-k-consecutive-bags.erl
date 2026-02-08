-module(maximum_coins).
-export([maximum_coins/2]).

maximum_coins(Piles, K) ->
    N = length(Piles),
    memo(Piles, K, 0, 0, N).

memo(Piles, K, Index, Coins, N) ->
    case K of
        0 -> Coins;
        _ ->
            case Index >= N of
                true -> 0;
                false ->
                    Pile = lists:nth(Index + 1, Piles),
                    PileLen = length(Pile),
                    memo_helper(Piles, K, Index, Coins, 0, PileLen, 0, N)
            end
    end.

memo_helper(Piles, K, Index, Coins, Take, PileLen, Acc, N) ->
    case Take > PileLen orelse Take > K of
        true -> Acc;
        false ->
            Pile = lists:nth(Index + 1, Piles),
            TakeCoins = sum(lists:sublist(Pile, 1, Take)),
            NewCoins = Coins + TakeCoins,
            NextK = K - Take,
            WithTake = memo(Piles, NextK, Index + 1, NewCoins, N),
            WithoutTake = case Take == 0 of
                              true ->
                                  memo_helper(Piles, K, Index, Coins, Take + 1, PileLen, Acc, N);
                              false ->
                                  0
                          end,
            WithoutTakeVal = case Take == 0 of
                                true -> 0;
                                false ->
                                    memo_helper(Piles, K, Index, Coins, Take + 1, PileLen, Acc, N)
                            end,

            NewAcc = max(Acc, WithTake),
            memo_helper(Piles, K, Index, Coins, Take + 1, PileLen, NewAcc, N)
    end.

sum(List) ->
    sum_helper(List, 0).

sum_helper([], Acc) ->
    Acc;
sum_helper([H|T], Acc) ->
    sum_helper(T, Acc + H).
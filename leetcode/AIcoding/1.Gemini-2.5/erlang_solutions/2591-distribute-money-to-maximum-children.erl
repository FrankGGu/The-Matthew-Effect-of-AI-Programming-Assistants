-module(solution).
-export([distribute_money/2]).

distribute_money(Money, Children) ->
    if
        Money < Children ->
            0;
        Children == 1 andalso Money == 4 ->
            0;
        true ->
            MaxK = min(Children, Money div 8),
            find_max_k(MaxK, Money, Children)
    end.

find_max_k(K, Money, Children) when K >= 0 ->
    RemainingChildren = Children - K,
    RemainingMoney = Money - 8 * K,
    if
        RemainingMoney < RemainingChildren ->
            find_max_k(K - 1, Money, Children);
        RemainingChildren == 1 andalso RemainingMoney == 4 ->
            find_max_k(K - 1, Money, Children);
        true ->
            K
    end.
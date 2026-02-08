-module(distribute_money).
-export([distMoney/2]).

distMoney(Money, Children) ->
    if Money < Children then
        0
    else
        MoneyLeft = Money - Children,
        if MoneyLeft == 0 then
            Children
        else
            FullPockets = MoneyLeft div 7,
            if FullPockets > Children then
                Children - 1
            else
                Remaining = MoneyLeft rem 7,
                if FullPockets == Children - 1 and Remaining == 3 then
                    FullPockets - 1
                else
                    FullPockets
                end
            end
        end
    end.
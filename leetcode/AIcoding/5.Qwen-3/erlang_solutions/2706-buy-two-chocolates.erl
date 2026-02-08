-module(buy_two_chocolates).
-export([buy_twoChocolates/2]).

buy_twoChocolates(Costs, Money) ->
    Sorted = lists:sort(Costs),
    [A | [B | _]] = Sorted,
    if
        A + B =< Money -> A + B;
        true -> -1
    end.
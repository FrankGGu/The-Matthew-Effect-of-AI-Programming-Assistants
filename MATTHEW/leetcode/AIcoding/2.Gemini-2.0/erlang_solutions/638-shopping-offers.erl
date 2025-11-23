-module(shopping_offers).
-export([shopping_offers/3]).

shopping_offers(Price, Special, Needs) ->
    shopping_offers(Price, Special, Needs, 0).

shopping_offers(Price, Special, Needs, Acc) ->
    case can_apply_special(Special, Needs) of
        [] ->
            calculate_without_special(Price, Needs, Acc);
        SpecialList ->
            lists:foldl(
                fun(S, MinCost) ->
                    NewNeeds = subtract_needs(Needs, S),
                    case NewNeeds of
                        error ->
                            MinCost;
                        NewNeedsList ->
                            NewCost = shopping_offers(Price, Special, NewNeedsList, Acc + lists:last(S)),
                            min(MinCost, NewCost)
                    end
                end,
                calculate_without_special(Price, Needs, Acc),
                SpecialList
            )
    end.

can_apply_special(Special, Needs) ->
    lists:filter(
        fun(S) ->
            lists:all(
                fun({Need, Index}) ->
                    lists:nth(Index + 1, S) =< Need
                end,
                lists:zip(Needs, lists:seq(0, length(Needs) - 1))
            )
        end,
        Special
    ).

subtract_needs(Needs, Special) ->
    Result = lists:zipwith(
        fun(Need, SpecialItem) ->
            Need - SpecialItem
        end,
        Needs,
        lists:sublist(Special, length(Needs))
    ),
    case lists:all(fun(X) -> X >= 0 end, Result) of
        true ->
            Result;
        false ->
            error
    end.

calculate_without_special(Price, Needs, Acc) ->
    lists:foldl(
        fun({Need, Index}, Sum) ->
            Sum + Need * lists:nth(Index + 1, Price)
        end,
        Acc,
        lists:zip(Needs, lists:seq(0, length(Needs) - 1))
    ).
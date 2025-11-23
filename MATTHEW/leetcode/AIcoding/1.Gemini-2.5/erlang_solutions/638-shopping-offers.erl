-module(solution).
-export([shopping_offers/3]).

shopping_offers(Price, Special, Needs) ->
    {MinCost, _} = solve(Price, Special, Needs, #{}),
    MinCost.

solve(Price, Special, Needs, Memo) ->
    case maps:find(Needs, Memo) of
        {ok, Cost} -> {Cost, Memo};
        error ->
            DirectCost = lists:sum(lists:zipwith(fun(N, P) -> N * P end, Needs, Price)),

            {FinalMinCost, FinalMemo} = lists:foldl(
                fun(Offer, {AccMinCost, AccMemo}) ->
                    OfferItems = lists:sublist(Offer, 1, length(Price)),
                    OfferPrice = lists:last(Offer),

                    NewNeeds = lists:zipwith(fun(N, OI) -> N - OI end, Needs, OfferItems),

                    CanApply = lists:all(fun(N) -> N >= 0 end, NewNeeds),

                    if CanApply ->
                        {SubProblemCost, UpdatedMemoFromSub} = solve(Price, Special, NewNeeds, AccMemo),
                        CostWithOffer = SubProblemCost + OfferPrice,
                        {min(AccMinCost, CostWithOffer), UpdatedMemoFromSub};
                    true ->
                        {AccMinCost, AccMemo}
                    end
                end,
                {DirectCost, Memo},
                Special
            ),

            NewMemo = maps:put(Needs, FinalMinCost, FinalMemo),
            {FinalMinCost, NewMemo}
    end.
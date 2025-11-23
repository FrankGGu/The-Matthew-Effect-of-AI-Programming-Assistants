-module(solution).
-export([maxNumberOfAlloys/6]).

maxNumberOfAlloys(_N, _K, Budget, Composition, Stock, Cost) ->
    lists:foldl(fun(FactoryComposition, AccMaxAlloys) ->
        CurrentFactoryMaxAlloys = binary_search(FactoryComposition, Stock, Cost, Budget),
        max(AccMaxAlloys, CurrentFactoryMaxAlloys)
    end, 0, Composition).

binary_search(FactoryComposition, Stock, Cost, Budget) ->
    Low = 0,
    High = 2000000000 + 1, % A sufficiently large upper bound for number of alloys (max budget + max stock)
    binary_search_recursive(Low, High, 0, FactoryComposition, Stock, Cost, Budget).

binary_search_recursive(Low, High, Ans, FactoryComposition, Stock, Cost, Budget) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case can_produce(Mid, FactoryComposition, Stock, Cost, Budget) of
        true ->
            binary_search_recursive(Mid + 1, High, Mid, FactoryComposition, Stock, Cost, Budget);
        false ->
            binary_search_recursive(Low, Mid - 1, Ans, FactoryComposition, Stock, Cost, Budget)
    end;
binary_search_recursive(_Low, _High, Ans, _FactoryComposition, _Stock, _Cost, _Budget) ->
    Ans.

can_produce(NumAlloys, FactoryComposition, Stock, Cost, Budget) ->
    if NumAlloys == 0 ->
        true;
    true ->
        TotalCost = calculate_cost(NumAlloys, FactoryComposition, Stock, Cost),
        TotalCost =< Budget
    end.

calculate_cost(NumAlloys, FactoryComposition, Stock, Cost) ->
    lists:foldl(fun({ReqAmountPerAlloy, CurrentStock, UnitCost}, AccCost) ->
        RequiredTotal = ReqAmountPerAlloy * NumAlloys,
        AmountToBuy = max(0, RequiredTotal - CurrentStock),
        AccCost + AmountToBuy * UnitCost
    end, 0, lists:zip3(FactoryComposition, Stock, Cost)).
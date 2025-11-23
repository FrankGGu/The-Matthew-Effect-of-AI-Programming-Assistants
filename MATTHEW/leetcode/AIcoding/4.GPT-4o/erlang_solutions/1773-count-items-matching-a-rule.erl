-module(solution).
-export([count_items_matching_rule/3]).

count_items_matching_rule(ItemList, RuleKey, RuleValue) ->
    lists:foldl(fun(Item, Acc) ->
        case lists:nth(1, Item) of
            {RuleKey, RuleValue} -> Acc + 1;
            _ -> Acc
        end
    end, 0, ItemList).
-module(solution).
-export([maximum_spending/2]).

maximum_spending(Items, Budget) ->
    lists:foldl(fun(Item, Acc) ->
        case Acc of
            {Max, RemBudget} when RemBudget >= Item -> 
                {erlang:max(Max, Item), RemBudget - Item};
            {Max, RemBudget} -> 
                {Max, RemBudget}
        end
    end, {0, Budget}, Items).
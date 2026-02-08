-module(solution).
-export([find_all_possible_recipes/2]).

find_all_possible_recipes(Recipes, Supplies) ->
    RecipesMap = lists:foldl(fun({Recipe, Ingredients}, Acc) ->
        maps:put(Recipe, Ingredients, Acc)
    end, #{}, Recipes),
    SuppliesSet = sets:from_list(Supplies),
    find_recipes(RecipesMap, SuppliesSet, []).

find_recipes(RecipesMap, SuppliesSet, Acc) ->
    case maps:to_list(RecipesMap) of
        [] -> Acc;
        [{Recipe, Ingredients} | Rest] ->
            if
                all_supplies_available(Ingredients, SuppliesSet) ->
                    find_recipes(maps:remove(Recipe, RecipesMap), SuppliesSet, [Recipe | Acc]);
                true ->
                    find_recipes(Rest, SuppliesSet, Acc)
            end
    end.

all_supplies_available(Ingredients, SuppliesSet) ->
    lists:all(fun(Ingredient) -> sets:is_element(Ingredient, SuppliesSet) end, Ingredients).
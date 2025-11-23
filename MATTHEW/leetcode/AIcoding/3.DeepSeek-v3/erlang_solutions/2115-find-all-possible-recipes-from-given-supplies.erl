-module(solution).
-export([find_all_recipes/3]).

find_all_recipes(Recipes, Ingredients, Supplies) ->
    SupplySet = sets:from_list(Supplies),
    RecipeMap = maps:from_list(lists:zip(Recipes, Ingredients)),
    Result = lists:filtermap(
        fun(Recipe) ->
            case can_make(Recipe, RecipeMap, SupplySet, sets:new()) of
                true -> {true, Recipe};
                false -> false
            end
        end,
        Recipes
    ),
    Result.

can_make(Recipe, RecipeMap, SupplySet, Visited) ->
    case sets:is_element(Recipe, SupplySet) of
        true -> true;
        false ->
            case maps:find(Recipe, RecipeMap) of
                {ok, IngredientList} ->
                    case sets:is_element(Recipe, Visited) of
                        true -> false;
                        false ->
                            NewVisited = sets:add_element(Recipe, Visited),
                            lists:all(
                                fun(Ingredient) ->
                                    can_make(Ingredient, RecipeMap, SupplySet, NewVisited)
                                end,
                                IngredientList
                            )
                    end;
                error -> false
            end
    end.
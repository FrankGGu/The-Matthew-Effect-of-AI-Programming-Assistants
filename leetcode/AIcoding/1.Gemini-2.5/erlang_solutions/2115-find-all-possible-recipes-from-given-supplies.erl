-module(solution).
-export([solve/3]).

solve(Recipes, Ingredients, Supplies) ->
    InitialSupplies = gb_sets:from_list(Supplies),

    RecipeDeps0 = maps:new(),
    RecipeToConsumers0 = maps:new(),
    InitialQueue0 = queue:new(),

    {InitialQueue, RecipeDeps, RecipeToConsumers} = 
        lists:foldl(fun({Recipe, RecipeIngredients}, {AccQueue, AccRecipeDeps, AccRecipeToConsumers}) ->
                        CurrentRecipeDeps = gb_sets:new(),
                        CurrentRecipeToConsumers = AccRecipeToConsumers,

                        {FinalRecipeDeps, FinalRecipeToConsumers} = 
                            lists:foldl(fun(Ingredient, {DepsAcc, ConsumersAcc}) ->
                                            if gb_sets:is_member(Ingredient, InitialSupplies) ->
                                                {DepsAcc, ConsumersAcc};
                                            true ->
                                                NewDepsAcc = gb_sets:add_element(Ingredient, DepsAcc),
                                                NewConsumersAcc = maps:update_with(
                                                                    Ingredient,
                                                                    fun(S) -> gb_sets:add_element(Recipe, S) end,
                                                                    gb_sets:from_list([Recipe]),
                                                                    ConsumersAcc
                                                                  ),
                                                {NewDepsAcc, NewConsumersAcc}
                                            end
                                        end, {CurrentRecipeDeps, CurrentRecipeToConsumers}, RecipeIngredients),

                        NewAccRecipeDeps = maps:put(Recipe, FinalRecipeDeps, AccRecipeDeps),

                        if gb_sets:is_empty(FinalRecipeDeps) ->
                            {queue:in(Recipe, AccQueue), NewAccRecipeDeps, FinalRecipeToConsumers};
                        true ->
                            {AccQueue, NewAccRecipeDeps, FinalRecipeToConsumers}
                        end
                    end, {InitialQueue0, RecipeDeps0, RecipeToConsumers0}, lists:zip(Recipes, Ingredients)),

    MadeRecipes = gb_sets:new(),

    process_queue(InitialQueue, RecipeDeps, RecipeToConsumers, MadeRecipes).

process_queue(Q, RecipeDepsMap, RecipeToConsumersMap, MadeRecipesSet) ->
    if queue:is_empty(Q) ->
        gb_sets:to_list(MadeRecipesSet);
    true ->
        {value, Recipe, Q1} = queue:out(Q),

        if gb_sets:is_member(Recipe, MadeRecipesSet) ->
            process_queue(Q1, RecipeDepsMap, RecipeToConsumersMap, MadeRecipesSet);
        true ->
            NewMadeRecipesSet = gb_sets:add_element(Recipe, MadeRecipesSet),

            Consumers = maps:get(Recipe, RecipeToConsumersMap, gb_sets:new()),

            {Q2, NewRecipeDepsMap} = 
                lists:foldl(fun(ConsumerRecipe, {AccQ, AccRecipeDeps}) ->
                                ConsumerDeps = maps:get(ConsumerRecipe, AccRecipeDeps),
                                UpdatedConsumerDeps = gb_sets:del_element(Recipe, ConsumerDeps),
                                AccRecipeDeps1 = maps:put(ConsumerRecipe, UpdatedConsumerDeps, AccRecipeDeps),

                                if gb_sets:is_empty(UpdatedConsumerDeps) ->
                                    {queue:in(ConsumerRecipe, AccQ), AccRecipeDeps1};
                                true ->
                                    {AccQ, AccRecipeDeps1}
                                end
                            end, {Q1, RecipeDepsMap}, gb_sets:to_list(Consumers)),

            process_queue(Q2, NewRecipeDepsMap, RecipeToConsumersMap, NewMadeRecipesSet)
        end
    end.
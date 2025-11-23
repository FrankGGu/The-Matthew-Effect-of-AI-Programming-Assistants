-module(find_recipes).
-export([allRecipes/2]).

allRecipes(Recipes, Ingredients) ->
  allRecipes(Recipes, Ingredients, []).

allRecipes([], _, Acc) ->
  lists:reverse(Acc);
allRecipes(Recipes, Ingredients, Acc) ->
  {Recipe, Dependencies} = lists:nth(1, Recipes),
  case canMake(Dependencies, Ingredients) of
    true ->
      NewRecipes = lists:delete(Recipe, Recipes),
      NewIngredients = [Recipe | Ingredients],
      allRecipes(NewRecipes, NewIngredients, [Recipe | Acc]);
    false ->
      NewRecipes = lists:sublist(Recipes, 2, length(Recipes) - 1),
      allRecipes(NewRecipes, Ingredients, Acc)
  end.

canMake([], _) ->
  true;
canMake([Ingredient | Rest], Ingredients) ->
  case lists:member(Ingredient, Ingredients) of
    true ->
      canMake(Rest, Ingredients);
    false ->
      false
  end.
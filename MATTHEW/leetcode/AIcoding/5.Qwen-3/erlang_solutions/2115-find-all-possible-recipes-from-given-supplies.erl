-module(recipe).
-export([find_all_recipes/2]).

find_all_recipes(Recipes, Ingredients) ->
    RecipesMap = maps:from_list([{Recipe, lists:seq(0, length(Ingredients) - 1)} || Recipe <- Recipes]),
    Supplied = sets:from_list(Ingredients),
    find_all_recipes(RecipesMap, Supplied, []).

find_all_recipes(_, _, Acc) when Acc == [] -> Acc;
find_all_recipes(RecipesMap, Supplied, Acc) ->
    NewAcc = [],
    {NewSupplied, NewAcc} = lists:foldl(fun({Recipe, Indexes}, {Supp, AccIn}) ->
        case all_supplied(Ingredients, Indexes, Supp) of
            true -> {sets:add_element(Recipe, Supp), [Recipe | AccIn]};
            false -> {Supp, AccIn}
        end
    end, {Supplied, NewAcc}, maps:to_list(RecipesMap)),
    if
        NewAcc == Acc -> Acc;
        true -> find_all_recipes(RecipesMap, NewSupplied, NewAcc)
    end.

all_supplied(_, [], _) -> true;
all_supplied(Ingredients, [I | Is], Supplied) ->
    case sets:is_element(lists:nth(I + 1, Ingredients), Supplied) of
        true -> all_supplied(Ingredients, Is, Supplied);
        false -> false
    end.
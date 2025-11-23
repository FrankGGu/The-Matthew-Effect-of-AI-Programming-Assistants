-module(food_ratings).
-export([new/3, change_rating/3, highest_rated/2]).

new(Foods, Cuisines, Ratings) ->
    FoodInfoMap = maps:new(),
    CuisineRatingsMap = maps:new(),

    Combined = lists:zip3(Foods, Cuisines, Ratings),

    {FoodInfoMapFinal, CuisineRatingsMapFinal} = lists:foldl(
        fun({Food, Cuisine, Rating}, Acc) ->
            {CurrentFoodInfoMap, CurrentCuisineRatingsMap} = Acc,

            NewFoodInfoMap = CurrentFoodInfoMap#{Food => {Cuisine, Rating}},

            NegRating = -Rating,
            TreeKey = {NegRating, Food},

            CuisineTree = maps:get(Cuisine, CurrentCuisineRatingsMap, gb_trees:empty()),
            NewCuisineTree = gb_trees:insert(TreeKey, ok, CuisineTree),
            NewCuisineRatingsMap = CurrentCuisineRatingsMap#{Cuisine => NewCuisineTree},

            {NewFoodInfoMap, NewCuisineRatingsMap}
        end,
        {FoodInfoMap, CuisineRatingsMap},
        Combined
    ),

    #{food_info => FoodInfoMapFinal, cuisine_ratings => CuisineRatingsMapFinal}.

change_rating(State, Food, NewRating) ->
    FoodInfoMap = maps:get(food_info, State),
    CuisineRatingsMap = maps:get(cuisine_ratings, State),

    {Cuisine, OldRating} = maps:get(Food, FoodInfoMap),

    NewFoodInfoMap = FoodInfoMap#{Food => {Cuisine, NewRating}},

    OldTreeKey = {-OldRating, Food},
    NewTreeKey = {-NewRating, Food},

    CuisineTree = maps:get(Cuisine, CuisineRatingsMap),

    TreeAfterDelete = gb_trees:delete(OldTreeKey, CuisineTree),

    TreeAfterInsert = gb_trees:insert(NewTreeKey, ok, TreeAfterDelete),

    NewCuisineRatingsMap = CuisineRatingsMap#{Cuisine => TreeAfterInsert},

    State#{food_info => NewFoodInfoMap, cuisine_ratings => NewCuisineRatingsMap}.

highest_rated(State, Cuisine) ->
    CuisineRatingsMap = maps:get(cuisine_ratings, State),
    CuisineTree = maps:get(Cuisine, CuisineRatingsMap),

    {{_NegRating, Food}, _Value} = gb_trees:min(CuisineTree),

    Food.
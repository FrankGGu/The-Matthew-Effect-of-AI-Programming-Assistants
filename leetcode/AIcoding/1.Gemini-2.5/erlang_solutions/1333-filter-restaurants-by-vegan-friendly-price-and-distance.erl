-module(solution).
-export([filter_restaurants/4]).

filter_restaurants(Restaurants, VeganFriendly, MaxPrice, MaxDistance) ->
    Filtered = lists:filter(fun([_Id, _Rating, RestaurantVF, RestaurantPrice, RestaurantDistance]) ->
                                (VeganFriendly == 0 orelse RestaurantVF == 1) andalso
                                (RestaurantPrice =< MaxPrice) andalso
                                (RestaurantDistance =< MaxDistance)
                            end, Restaurants),
    Sorted = lists:sort(fun([IdA, RatingA, _, _, _], [IdB, RatingB, _, _, _]) ->
                                if
                                    RatingA =/= RatingB -> RatingA > RatingB;
                                    true -> IdA > IdB
                                end
                        end, Filtered),
    lists:map(fun([Id, _, _, _, _]) -> Id end, Sorted).
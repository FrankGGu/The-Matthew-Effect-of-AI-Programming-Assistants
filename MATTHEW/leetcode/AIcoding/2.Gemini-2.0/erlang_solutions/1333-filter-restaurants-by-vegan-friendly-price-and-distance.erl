-module(filter_restaurants).
-export([filter_restaurants/3]).

filter_restaurants(Restaurants, VeganFriendly, MaxPrice, MaxDistance) ->
  lists:filter(
    fun(Restaurant) ->
      case VeganFriendly of
        1 ->
          (lists:nth(2, Restaurant) == 1) andalso
            (lists:nth(3, Restaurant) =< MaxPrice) andalso
            (lists:nth(4, Restaurant) =< MaxDistance);
        0 ->
          (lists:nth(3, Restaurant) =< MaxPrice) andalso
            (lists:nth(4, Restaurant) =< MaxDistance)
      end
    end,
    Restaurants
  )
  |> lists:keysort(1, lists:sort(
    fun(A, B) ->
      case lists:nth(1, A) =:= lists:nth(1, B) of
        true ->
          lists:nth(0, A) > lists:nth(0, B);
        false ->
          lists:nth(1, A) > lists:nth(1, B)
      end
    end,
    [] ++ [ {lists:nth(0, X), X} || X <- _]
  ))
  |> [lists:nth(0, X) || X <- _].
-module(min_garden_perimeter).
-export([minimum_perimeter/1]).

minimum_perimeter(NeededApples) ->
  find_perimeter(NeededApples, 1, 1).

find_perimeter(NeededApples, Layer, Perimeter) ->
  Apples := apples_in_layer(Layer),
  if Apples >= NeededApples ->
    Perimeter;
  true ->
    find_perimeter(NeededApples - Apples, Layer + 1, (Layer + 1) * 8)
  end.

apples_in_layer(Layer) ->
  12 * Layer * Layer.
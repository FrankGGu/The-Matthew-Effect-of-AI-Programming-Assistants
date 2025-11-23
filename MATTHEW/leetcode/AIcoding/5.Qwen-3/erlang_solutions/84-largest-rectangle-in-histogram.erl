-module(largest_rectangle_in_histogram).
-export([largest_rectangle_area/1]).

largest_rectangle_area(Histogram) ->
    largest_rectangle_area(Histogram, [], 0).

largest_rectangle_area([], Stack, MaxArea) ->
    largest_rectangle_area(Stack, MaxArea);
largest_rectangle_area([H | T], Stack, MaxArea) ->
    NewStack = process_height(H, Stack, 0),
    largest_rectangle_area(T, NewStack, MaxArea).

process_height(H, [], Index) ->
    [{H, Index} | []];
process_height(H, [{TopH, TopIndex} | Rest], Index) when H >= TopH ->
    [{H, Index} | {TopH, TopIndex} | Rest];
process_height(H, [{TopH, TopIndex} | Rest], Index) ->
    Area = TopH * (Index - TopIndex),
    largest_rectangle_area([{TopH, TopIndex} | Rest], Index, Area).

largest_rectangle_area([], MaxArea) ->
    MaxArea;
largest_rectangle_area([{H, Index} | Rest], MaxArea) ->
    Area = H * (length(Rest) + 1),
    largest_rectangle_area(Rest, max(MaxArea, Area)).

largest_rectangle_area(Stack, MaxArea) ->
    largest_rectangle_area(Stack, 0, MaxArea).

largest_rectangle_area([], _, MaxArea) ->
    MaxArea;
largest_rectangle_area([{H, Index} | Rest], Index, MaxArea) ->
    Area = H * (length(Rest) + 1),
    largest_rectangle_area(Rest, Index + 1, max(MaxArea, Area)).
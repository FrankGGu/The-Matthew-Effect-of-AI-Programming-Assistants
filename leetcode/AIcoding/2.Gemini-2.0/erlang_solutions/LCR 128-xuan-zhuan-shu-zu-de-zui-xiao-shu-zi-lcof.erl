-module(inventory_management_i).
-export([find_products/2]).

find_products(Products, Threshold) ->
  lists:filter(fun(P) -> P =< Threshold end, Products).
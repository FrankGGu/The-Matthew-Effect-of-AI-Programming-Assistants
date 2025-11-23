-module(ant_on_the_boundary).
-export([ant_on_the_boundary/1]).

ant_on_the_boundary(Nums) ->
    ant_on_the_boundary(Nums, 0).

ant_on_the_boundary([], Sum) ->
    if Sum == 0 -> true
    else false
    end;

ant_on_the_boundary([H|T], Sum) ->
    ant_on_the_boundary(T, Sum + H).
-module(solution).
-export([sort_people/1]).

sort_people(Names) ->
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Names),
    [Name || {Name, _} <- Sorted].
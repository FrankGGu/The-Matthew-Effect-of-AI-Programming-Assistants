-module(solution).
-export([people_not_subset/2]).

people_not_subset(Favorites, Companies) ->
    Lists = lists:map(fun({Name, List}) -> {Name, lists:sort(List)} end, Favorites),
    Filtered = lists:filter(fun({_, List}) -> not lists:any(fun({_, Other}) -> lists:is_subset(List, Other) end, Lists) end, Lists),
    lists:map(fun({Name, _}) -> Name end, Filtered).

is_subset(Sub, List) ->
    lists:all(fun(X) -> lists:member(X, List) end, Sub).
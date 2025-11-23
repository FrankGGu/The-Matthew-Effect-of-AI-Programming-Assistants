-module(reward_top_k_students).
-export([topStudents/2]).

topStudents(Names, Sums) ->
    Lists = lists:zip(Names, Sums),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Lists),
    TopK = lists:sublist(Sorted, 3),
    [Name || {Name, _} <- TopK].
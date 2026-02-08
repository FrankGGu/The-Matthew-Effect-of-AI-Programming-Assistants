-module(compare_strings).

-export([num_smaller_by_frequency/2]).

f(S) ->
    Sorted = lists:sort(S),
    [H|_] = Sorted,
    length(lists:takewhile(fun(C) -> C =:= H end, Sorted)).

num_smaller_by_frequency(Queries, Words) ->
    WordFs = lists:map(fun f/1, Words),
    lists:map(fun(Query) ->
                  QueryF = f(Query),
                  length(lists:filter(fun(WF) -> WF > QueryF end, WordFs))
              end, Queries).
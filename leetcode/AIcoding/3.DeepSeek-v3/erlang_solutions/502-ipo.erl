-module(ipo).
-export([find_maximized_capital/4]).

find_maximized_capital(K, W, Profits, Capital) ->
    {ok, PQ} = pqueue:new(max),
    Projects = lists:zip(Profits, Capital),
    SortedProjects = lists:sort(fun({_, C1}, {_, C2}) -> C1 =< C2 end, Projects),
    find_maximized_capital(K, W, SortedProjects, PQ).

find_maximized_capital(0, W, _, _) -> W;
find_maximized_capital(K, W, Projects, PQ) ->
    {Available, Remaining} = lists:partition(fun({_, C}) -> C =< W end, Projects),
    NewPQ = lists:foldl(fun({P, _}, Acc) -> pqueue:in(P, P, Acc) end, PQ, Available),
    case pqueue:is_empty(NewPQ) of
        true -> W;
        false ->
            {{value, P}, UpdatedPQ} = pqueue:out(NewPQ),
            find_maximized_capital(K - 1, W + P, Remaining, UpdatedPQ)
    end.
-module(solution).
-export([find_maximized_capital/4]).

-define(MAX_PROJECTS, 100000).

%% The function finds the maximum capital after k projects.
-spec find_maximized_capital(integer(), integer(), [integer()], [integer()]) -> integer().
find_maximized_capital(K, W, Profits, Capitals) ->
    Projects = lists:zip(Capitals, Profits),
    SortedProjects = lists:sort(fun {Cap1, _} {Cap2, _} -> Cap1 < Cap2 end, Projects),
    find_maximized_capital(K, W, SortedProjects, []).

%% The recursive helper function to maximize the capital by choosing at most K projects.
-spec find_maximized_capital(integer(), integer(), [tuple()], [integer()]) -> integer().
find_maximized_capital(0, W, _, _) -> W;
find_maximized_capital(_, W, [], _) -> W;
find_maximized_capital(K, W, [{Capital, Profit}|Rest], MaxHeap) when Capital <= W ->
    find_maximized_capital(K - 1, W + Profit, Rest, lists:sort(fun (X, Y) -> X > Y end, [Profit|MaxHeap]));
find_maximized_capital(K, W, [{Capital, _}|Rest], MaxHeap) ->
    find_maximized_capital(K, W, Rest, MaxHeap).


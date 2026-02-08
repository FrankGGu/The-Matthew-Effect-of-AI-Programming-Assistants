-module(solution).
-export([get_strongest/2]).

get_strongest(A, K) ->
    N = length(A),
    SortedA = lists:sort(fun(X, Y) -> X > Y end, A),
    Median = lists:nth((N + 1) div 2, SortedA),
    Strongest = [X || X <- A, X > Median],
    if length(Strongest) >= K ->
        StrongestK = lists:sublist(Strongest, K);
    true ->
        StrongestK = Strongest
    end,
    StrongestK ++ [X || X <- A, not lists:member(X, StrongestK)],
    lists:sublist(lists:sort(fun(X, Y) -> X > Y end, StrongestK), K).
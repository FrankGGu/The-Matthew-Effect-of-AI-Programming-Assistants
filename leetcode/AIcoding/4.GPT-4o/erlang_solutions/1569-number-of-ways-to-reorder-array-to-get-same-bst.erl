-module(solution).
-export([numOfWays/1]).

numOfWays(R) ->
    N = length(R),
    Count = count(R),
    factorial(N) div (factorial(Count) * factorial(N - Count)) * count_ways(R).

count([]) -> 0;
count([H | T]) -> 
    lists:foldl(fun(X, Acc) -> if X > H -> Acc + 1; true -> Acc end end, 0, T).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).

count_ways([]) -> 1;
count_ways([H | T]) ->
    Left = lists:filter(fun(X) -> X < H end, T),
    Right = lists:filter(fun(X) -> X > H end, T),
    count_ways(Left) * count_ways(Right).
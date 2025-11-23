-module(solution).
-export([count_ways/1]).

count_ways(Buildings) ->
    N = length(Buildings),
    Total = lists:foldl(fun(X, Acc) -> Acc + (if X == 1 -> 1; true -> 0 end) end, 0, Buildings),
    if Total < 3 -> 0; true -> calculate_ways(Buildings, Total, N) end.

calculate_ways(Buildings, Total, N) ->
    select(1, Buildings, Total, N, 0).

select(0, _Buildings, _Total, _N, _Count) -> 1;
select(_, [], _, _, _) -> 0;
select(K, [H|T], Total, N, Count) ->
    case H of
        1 -> select(K - 1, T, Total - 1, N - 1, Count + 1) + select(K, T, Total, N - 1, Count);
        0 -> select(K, T, Total, N - 1, Count)
    end.
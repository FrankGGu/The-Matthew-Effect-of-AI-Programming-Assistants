-module(solution).
-export([max_adjacent_difference/1]).

max_adjacent_difference(List) ->
    N = length(List),
    MaxDiff = lists:foldl(fun({X, Y}, Acc) -> max(Acc, abs(X - Y)) end, 0, zip(List, rotate(List))),
    MaxDiff.

zip([], _) -> [];
zip([H1 | T1], [H2 | T2]) -> [{H1, H2} | zip(T1, T2)].

rotate(List) -> 
    case List of
        [] -> [];
        [H | T] -> T ++ [H]
    end.
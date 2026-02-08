-module(earliest_second_to_mark_indices_ii).
-export([latest_second/1]).

latest_second(Numbers) ->
    N = length(Numbers),
    Max = lists:max(Numbers),
    Count = lists:foldl(fun(X, Acc) -> Acc + (if X == Max -> 1; true -> 0 end) end, 0, Numbers),
    if
        Count > 1 -> N - 1;
        true -> lists:foldl(fun({I, X}, Acc) -> if X == Max -> I; true -> Acc end end, -1, lists:zip(lists:seq(0, N-1), Numbers))
    end.
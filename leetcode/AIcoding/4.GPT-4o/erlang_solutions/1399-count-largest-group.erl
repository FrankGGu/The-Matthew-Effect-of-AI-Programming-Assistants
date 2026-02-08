-module(solution).
-export([count_largest_group/1]).

count_largest_group(N) ->
    Groups = lists:foldl(fun(X, Acc) ->
        Sum = sum_digits(X),
        maps:update_with(Sum, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, lists:seq(1, N)),
    MaxCount = lists:max(maps:values(Groups)),
    lists:filter(fun({_, V}) -> V == MaxCount end, maps:to_list(Groups)) |> length().

sum_digits(0) -> 0;
sum_digits(N) -> N rem 10 + sum_digits(N div 10).
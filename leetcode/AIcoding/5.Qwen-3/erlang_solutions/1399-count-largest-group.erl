-module(solution).
-export([count_largest_group/1]).

count_largest_group(N) ->
    Groups = lists:foldl(fun(I, Acc) -> 
        Key = sum_digits(I),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, lists:seq(1, N)),
    MaxSize = lists:max(maps:values(Groups)),
    lists:foldl(fun({_K, V}, Acc) -> if V == MaxSize -> Acc + 1; true -> Acc end end, 0, maps:to_list(Groups)).

sum_digits(N) ->
    sum_digits(N, 0).

sum_digits(0, Acc) ->
    Acc;
sum_digits(N, Acc) ->
    sum_digits(N div 10, Acc + (N rem 10)).
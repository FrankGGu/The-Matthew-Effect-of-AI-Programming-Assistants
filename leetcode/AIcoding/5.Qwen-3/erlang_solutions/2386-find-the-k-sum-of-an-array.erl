-module(k_sum).
-export([k_sum/2]).

k_sum(List, K) ->
    Sorted = lists:sort(List),
    Sums = generate_sums(Sorted, []),
    lists:nth(K, Sums).

generate_sums([], Acc) ->
    Acc;
generate_sums([H | T], Acc) ->
    NewAcc = lists:map(fun(X) -> X + H end, Acc) ++ [H],
    generate_sums(T, Acc ++ NewAcc).

k_sum_1(List, K) ->
    Sorted = lists:sort(List),
    Sums = generate_sums_1(Sorted, []),
    lists:nth(K, Sums).

generate_sums_1([], Acc) ->
    Acc;
generate_sums_1([H | T], Acc) ->
    NewAcc = lists:map(fun(X) -> X + H end, Acc) ++ [H],
    generate_sums_1(T, Acc ++ NewAcc).
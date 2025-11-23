-module(arithmetic_subarrays).
-export([are_almost_arithmetic/1]).

are_almost_arithmetic(Nums) ->
    lists:filter(fun(Sub) -> is_arithmetic(Sub) end, generate_subarrays(Nums)).

generate_subarrays(Nums) ->
    generate_subarrays(Nums, []).

generate_subarrays([], Acc) ->
    Acc;
generate_subarrays([H|T], Acc) ->
    generate_subarrays(T, [lists:sublist(Nums, 1, length(Nums) - index(H, Nums)) | Acc]).

index(_, []) ->
    0;
index(X, [X|_]) ->
    1;
index(X, [_|T]) ->
    1 + index(X, T).

is_arithmetic([]) ->
    false;
is_arithmetic([_]) ->
    false;
is_arithmetic([_, _]) ->
    true;
is_arithmetic(List) ->
    Sorted = lists:sort(List),
    Diff = Sorted[2] - Sorted[1],
    is_arithmetic(Sorted, Diff).

is_arithmetic([A, B | Rest], Diff) ->
    if
        B - A == Diff ->
            is_arithmetic([B | Rest], Diff);
        true ->
            false
    end;
is_arithmetic(_, _) ->
    true.
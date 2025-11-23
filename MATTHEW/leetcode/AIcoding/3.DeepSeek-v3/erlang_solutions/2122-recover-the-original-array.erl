-module(solution).
-export([recover_array/1]).

recover_array(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Ks = find_possible_ks(Sorted, N),
    find_valid_k(Sorted, Ks).

find_possible_ks(Sorted, N) ->
    First = lists:nth(1, Sorted),
    Ks = lists:foldl(fun(I, Acc) ->
        Diff = lists:nth(I, Sorted) - First,
        if Diff > 0, Diff rem 2 == 0 -> [Diff div 2 | Acc];
           true -> Acc
        end
    end, [], lists:seq(2, N)),
    lists:usort(Ks).

find_valid_k(Sorted, []) -> [];
find_valid_k(Sorted, [K | Rest]) ->
    case try_recover(Sorted, K) of
        {ok, Res} -> Res;
        error -> find_valid_k(Sorted, Rest)
    end.

try_recover(Sorted, K) ->
    try_recover(Sorted, K, [], []).

try_recover([], _, Lower, Res) ->
    if Lower == [] -> {ok, Res};
       true -> error
    end;
try_recover([H | T], K, Lower, Res) ->
    case lists:member(H - 2 * K, Lower) of
        true ->
            NewLower = lists:delete(H - 2 * K, Lower),
            try_recover(T, K, NewLower, [H - K | Res]);
        false ->
            try_recover(T, K, [H | Lower], Res)
    end.
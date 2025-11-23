-module(k_avoiding_array).
-export([min_sum/2]).

min_sum(K, N) ->
    List = lists:seq(1, N),
    find_min_sum(List, K, 0).

find_min_sum([], _, Sum) ->
    Sum;
find_min_sum([H | T], K, Sum) ->
    case is_valid(H, T, K) of
        true ->
            find_min_sum(T, K, Sum + H);
        false ->
            find_min_sum(T, K, Sum)
    end.

is_valid(_, [], _) ->
    true;
is_valid(X, [Y | Ys], K) ->
    if
        X + Y == K ->
            false;
        true ->
            is_valid(X, Ys, K)
    end.
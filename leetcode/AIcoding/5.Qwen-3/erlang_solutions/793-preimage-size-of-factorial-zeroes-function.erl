-module(solution).
-export([preimage_size/1]).

preimage_size(N) ->
    find_k(N, 0, 1000000000).

find_k(N, Low, High) ->
    Mid = (Low + High) div 2,
    Count = count_trailing_zeros(Mid),
    case Count of
        C when C < N -> find_k(N, Mid + 1, High);
        C when C > N -> find_k(N, Low, Mid - 1);
        _ -> find_left_bound(N, Low, Mid)
    end.

count_trailing_zeros(X) ->
    count_trailing_zeros(X, 0).

count_trailing_zeros(0, Acc) ->
    Acc;
count_trailing_zeros(X, Acc) ->
    count_trailing_zeros(X div 5, Acc + X div 5).

find_left_bound(N, Low, High) ->
    if
        Low == High -> High;
        true ->
            Mid = (Low + High) div 2,
            Count = count_trailing_zeros(Mid),
            case Count of
                C when C < N -> find_left_bound(N, Mid + 1, High);
                _ -> find_left_bound(N, Low, Mid)
            end
    end.
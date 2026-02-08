-module(solution).
-export([previous_permutation/1]).

previous_permutation(P) ->
    N = length(P),
    case find_first_decreasing(P, N) of
        -1 -> lists:reverse(P);
        K ->
            L = find_largest_smaller(P, K, N),
            swap(P, K, L)
    end.

find_first_decreasing(P, N) ->
    lists:foldl(fun(X, {Index, Prev}) ->
        case Prev < X of
            true -> Index;
            false -> {Index + 1, X}
        end
    end, {-1, hd(P)}, tl(P)).

find_largest_smaller(P, K, N) ->
    {_, L} = lists:foldl(fun(X, {BestIndex, BestValue}) ->
        if 
            X < lists:nth(K + 1, P) andalso X > BestValue ->
                {lists:nth(1 + lists:member(X, P), P), X};
            true ->
                {BestIndex, BestValue}
        end
    end, {lists:nth(1, P), -1}, tl(P)),
    L.

swap(P, I, J) ->
    lists:map(fun(X, Index) ->
        case Index of
            I -> lists:nth(J + 1, P);
            J -> lists:nth(I + 1, P);
            _ -> X
        end
    end, P, lists:seq(0, length(P) - 1)).
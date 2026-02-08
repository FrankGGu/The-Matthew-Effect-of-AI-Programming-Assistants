-module(same_average).
-export([split_array/1]).

split_array(A) ->
    N = length(A),
    if
        N =< 1 -> false;
        true ->
            Sum = lists:sum(A),
            K = N div 2,
            Max = (N * Sum) rem N,
            case find(K, Sum, A, N, 0, 0, 0, 0) of
                true -> true;
                _ -> false
            end
    end.

find(0, _, _, _, _, _, _, _) -> true;
find(_, _, [], _, _, _, _, _) -> false;
find(K, Sum, [H|T], N, I, S, C, P) ->
    case (C < K) andalso ((S + H) * N <= Sum * (I + 1)) of
        true ->
            case find(K - 1, Sum, T, N, I + 1, S + H, C + 1, P + H) of
                true -> true;
                _ -> find(K, Sum, T, N, I, S, C, P)
            end;
        _ -> find(K, Sum, T, N, I, S, C, P)
    end.
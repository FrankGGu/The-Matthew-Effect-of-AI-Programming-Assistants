-module(kth_smallest_instructions).
-export([kth_smallest/3]).

kth_smallest(H, V, K) ->
    paths(H, V, K, "", 1).

paths(0, 0, 1, Acc, _) ->
    lists:reverse(Acc);
paths(H, V, K, Acc, Count) ->
    Total := combinations(H + V, H),
    if
        Count > K ->
            [];
        H > 0 ->
            HComb := combinations(H + V - 1, H - 1),
            if
                Count + HComb > K ->
                    paths(H - 1, V, K, "H" ++ Acc, Count);
                true ->
                    paths(H, V - 1, K, "V" ++ Acc, Count + HComb)
            end;
        true ->
            lists:duplicate(V, "V") ++ Acc
    end.

combinations(N, K) ->
    case K of
        0 -> 1;
        N -> 1;
        _ when K > N -> 0;
        _ ->
            fact(N) div (fact(K) * fact(N - K))
    end.

fact(0) -> 1;
fact(N) -> N * fact(N - 1).
-module(solution).
-export([fib_sum/1]).

fib_sum(K) ->
    FibListDesc = generate_fibs_desc(1, 1, K, []),
    greedy_sum(K, FibListDesc, 0).

generate_fibs_desc(A, B, MaxK, Acc) ->
    if B > MaxK ->
        Acc;
    else
        generate_fibs_desc(B, A + B, MaxK, [B | Acc])
    end.

greedy_sum(0, _Fibs, Count) ->
    Count;
greedy_sum(K, [H | T], Count) ->
    if H =< K ->
        greedy_sum(K - H, [H | T], Count + 1);
    else
        greedy_sum(K, T, Count)
    end;
greedy_sum(K, [], Count) when K > 0 ->
    Count.
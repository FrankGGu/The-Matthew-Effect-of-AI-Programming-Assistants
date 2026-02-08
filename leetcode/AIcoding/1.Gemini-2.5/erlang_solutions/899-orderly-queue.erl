-module(solution).
-export([orderly_queue/2]).

orderly_queue(S, K) ->
    if K == 1 ->
        Shifts = generate_cyclic_shifts(S),
        lists:min(Shifts);
    true -> % K >= 2
        lists:sort(S)
    end.

generate_cyclic_shifts(S) ->
    Len = length(S),
    generate_shifts_loop(S, Len, []).

generate_shifts_loop(_CurrentS, 0, Acc) ->
    lists:reverse(Acc);
generate_shifts_loop(CurrentS, N, Acc) ->
    NextS = tl(CurrentS) ++ [hd(CurrentS)],
    generate_shifts_loop(NextS, N-1, [CurrentS | Acc]).
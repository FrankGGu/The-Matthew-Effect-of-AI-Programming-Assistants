-module(solution).
-export([longest_arith_seq_length/2]).

longest_arith_seq_length(A, D) ->
    maps:fold(fun (X, Acc) ->
        PrevCount = maps:get(X - D, Acc, 0),
        NewCount = PrevCount + 1,
        maps:put(X, NewCount, Acc)
    end, #{}, A)
    |> maps:fold(fun (_, V, Max) -> max(V, Max) end, 0).
-module(minimum_operations).
-export([minOperations/1]).

minOperations(N) ->
    min_operations(N, 0).

min_operations(0, Count) ->
    Count;
min_operations(N, Count) ->
    Lsb = N band 1;
    if
        Lsb == 0 ->
            min_operations(N bsr 1, Count);
        true ->
            if
                (N band 2) == 0 ->
                    min_operations(N - 1, Count + 1);
                true ->
                    if N == 3 ->
                        Count + 2;
                    true ->
                        min_operations(N + 1, Count + 1)
                    end
            end
    end.
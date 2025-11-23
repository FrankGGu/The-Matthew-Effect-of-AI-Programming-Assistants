-module(solve).
-export([sort_by_bit/1]).

sort_by_bit(Numbers) ->
    lists:sort(fun(A, B) ->
        CountA = count_ones(A),
        CountB = count_ones(B),
        if
            CountA < CountB -> true;
            CountA > CountB -> false;
            true -> A =< B
        end
    end, Numbers).

count_ones(N) ->
    count_ones(N, 0).

count_ones(0, Count) ->
    Count;
count_ones(N, Count) ->
    count_ones(N band (N-1), Count + 1).
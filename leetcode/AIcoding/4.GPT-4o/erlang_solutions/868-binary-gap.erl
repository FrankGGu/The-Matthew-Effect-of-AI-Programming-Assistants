-module(solution).
-export([binary_gap/1]).

binary_gap(N) ->
    Bin = integer_to_list(N, 2),
    binary_gap_aux(Bin, 0, 0).

binary_gap_aux([], _, Max) ->
    Max;
binary_gap_aux([48 | Rest], Count, Max) ->
    binary_gap_aux(Rest, Count + 1, Max);
binary_gap_aux([49 | Rest], Count, Max) ->
    binary_gap_aux(Rest, 0, max(Count, Max)).
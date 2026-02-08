-module(solution).
-export([find_peaks/1]).

find_peaks(List) ->
    find_peaks_helper(List, 0, []).

find_peaks_helper([], _, Acc) -> 
    lists:reverse(Acc);
find_peaks_helper([_], _, Acc) -> 
    lists:reverse(Acc);
find_peaks_helper([H1, H2 | T], Index, Acc) when H1 > H2 ->
    find_peaks_helper([H2 | T], Index + 1, [Index | Acc]);
find_peaks_helper([H1, H2 | T], Index, Acc) ->
    find_peaks_helper([H2 | T], Index + 1, Acc).
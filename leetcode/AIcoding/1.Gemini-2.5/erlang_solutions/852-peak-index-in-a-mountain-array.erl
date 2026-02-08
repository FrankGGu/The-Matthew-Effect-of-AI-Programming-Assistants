-module(solution).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(Arr) ->
    find_peak(Arr, 0).

find_peak([H1, H2 | T], Index) when H1 < H2 ->
    find_peak([H2 | T], Index + 1);
find_peak([_H1, _H2 | _T], Index) ->
    Index.
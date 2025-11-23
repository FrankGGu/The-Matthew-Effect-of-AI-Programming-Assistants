-module(solution).
-export([zero_filled_subarray/1]).

zero_filled_subarray(List) ->
    zero_filled_subarray(List, 0, 0).

zero_filled_subarray([], Count, Acc) ->
    Acc + Count * (Count + 1) div 2;
zero_filled_subarray([0 | T], Count, Acc) ->
    zero_filled_subarray(T, Count + 1, Acc);
zero_filled_subarray([_ | T], 0, Acc) ->
    zero_filled_subarray(T, 0, Acc);
zero_filled_subarray([_ | T], Count, Acc) ->
    zero_filled_subarray(T, 0, Acc + Count * (Count + 1) div 2).
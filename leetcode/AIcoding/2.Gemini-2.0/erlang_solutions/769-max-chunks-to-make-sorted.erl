-module(max_chunks_to_make_sorted).
-export([max_chunks_to_sorted/1]).

max_chunks_to_sorted(Arr) ->
    max_chunks_to_sorted(Arr, 0, 0, 0).

max_chunks_to_sorted([], Max, CurrMax, Count) ->
    Count;
max_chunks_to_sorted([H|T], Max, CurrMax, Count) ->
    NewCurrMax = max(CurrMax, H),
    if NewCurrMax == Max ->
        max_chunks_to_sorted(T, Max + 1, 0, Count + 1);
    true ->
        max_chunks_to_sorted(T, Max, NewCurrMax, Count)
    end.
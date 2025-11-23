-module(solution).
-export([rearrangeBarcodes/1]).

rearrangeBarcodes(Barcodes) ->
    FreqMap = count_frequencies(Barcodes),
    SortedFreqs = lists:sort(fun({C1, _}, {C2, _}) -> C1 >= C2 end, maps:to_list(FreqMap)),

    FlatList = flatten_freqs(SortedFreqs),

    Len = length(FlatList),
    Mid = (Len + 1) div 2,

    FirstHalf = lists:sublist(FlatList, Mid),
    SecondHalf = lists:nthtail(Mid, FlatList),

    interleave(FirstHalf, SecondHalf).

count_frequencies(Barcodes) ->
    lists:foldl(fun(Barcode, Acc) ->
        maps:update_with(Barcode, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:new(), Barcodes).

flatten_freqs(SortedFreqs) ->
    [Barcode || {Count, Barcode} <- SortedFreqs, _ <- lists:seq(1, Count)].

interleave([], L) -> L;
interleave(L, []) -> L;
interleave([H1|T1], [H2|T2]) -> [H1, H2 | interleave(T1, T2)].
-module(solution).
-export([reorganize_string/1]).

reorganize_string(S) ->
    Len = length(S),
    FreqMap = count_frequencies(S, maps:new()),
    SortedFreqs = lists:sort(fun({_C1, N1}, {_C2, N2}) -> N1 >= N2 end, maps:to_list(FreqMap)),

    case SortedFreqs of
        [] ->
            "";
        [{_Char, MaxFreq} | _] when MaxFreq > (Len + 1) div 2 ->
            "";
        _ ->
            ResultList = lists:duplicate(Len, $ ),
            FinalList = fill_loop(SortedFreqs, ResultList, 0, Len),
            list_to_binary(FinalList)
    end.

count_frequencies([], Acc) -> Acc;
count_frequencies([H | T], Acc) ->
    count_frequencies(T, maps:update_with(H, fun(V) -> V + 1 end, 1, Acc)).

fill_loop([], ResultList, _CurrentWriteIndex, _TotalLength) ->
    ResultList;
fill_loop([{Char, Count} | RestFreqs], CurrentResultList, CurrentWriteIndex, TotalLength) ->
    {UpdatedResultList, NextWriteIndex} =
        place_char_n_times(Char, Count, CurrentResultList, CurrentWriteIndex, TotalLength),
    fill_loop(RestFreqs, UpdatedResultList, NextWriteIndex, TotalLength).

place_char_n_times(Char, Count, ResultList, CurrentWriteIndex, TotalLength) ->
    place_char_n_times_acc(Char, Count, ResultList, CurrentWriteIndex, TotalLength).

place_char_n_times_acc(_Char, 0, CurrentResultList, CurrentWriteIndex, _TotalLength) ->
    {CurrentResultList, CurrentWriteIndex};
place_char_n_times_acc(Char, RemainingCount, CurrentResultList, CurrentWriteIndex, TotalLength) ->
    ActualIndex = CurrentWriteIndex + 1,
    NewResultList = lists:replace_at(ActualIndex, Char, CurrentResultList),

    NextWriteIndexCandidate = CurrentWriteIndex + 2,
    NewWriteIndex =
        if NextWriteIndexCandidate >= TotalLength ->
            1;
        true ->
            NextWriteIndexCandidate
        end,
    place_char_n_times_acc(Char, RemainingCount - 1, NewResultList, NewWriteIndex, TotalLength).
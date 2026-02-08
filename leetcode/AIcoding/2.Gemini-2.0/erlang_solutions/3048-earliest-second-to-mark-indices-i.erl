-module(earliest_second_to_mark_indices_i).
-export([earliestSecondToMarkIndices/2]).

earliestSecondToMarkIndices(Nums, ChangeIndices) ->
    earliestSecondToMarkIndices(Nums, ChangeIndices, 1, length(ChangeIndices)).

earliestSecondToMarkIndices(Nums, ChangeIndices, Low, High) ->
    if Low > High then
        -1
    else
        Mid = (Low + High) div 2,
        if canMark(Nums, ChangeIndices, Mid) then
            if Low == Mid then
                Mid
            else
                earliestSecondToMarkIndices(Nums, ChangeIndices, Low, Mid - 1)
            end
        else
            earliestSecondToMarkIndices(Nums, ChangeIndices, Mid + 1, High)
        end
    end.

canMark(Nums, ChangeIndices, Limit) ->
    N = length(Nums),
    LastOccurrences = lists:seq(1, N, fun(Index) -> 0 end),
    for(1, Limit, 1, fun(I) ->
        Index = lists:nth(I, ChangeIndices),
        LastOccurrences ! Index + I
    end),
    IndicesToMark = [Index || Index <- lists:seq(1,N), LastOccurrences ! Index > 0 and LastOccurrences ! Index =< Limit],
    lists:sort(IndicesToMark, fun(A,B) -> LastOccurrences ! A < LastOccurrences ! B end),
    canMarkHelper(Nums, IndicesToMark, ChangeIndices, Limit, 0).

canMarkHelper(_Nums, [], _ChangeIndices, _Limit, _Available) ->
    true;
canMarkHelper(Nums, [Index | Rest], ChangeIndices, Limit, Available) ->
    IndexTime = findIndexTime(Index, ChangeIndices, Limit),
    if IndexTime == -1 then
        false
    else
        Need = lists:nth(Index, Nums),
        if Available >= Need then
            canMarkHelper(Nums, Rest, ChangeIndices, Limit, Available - Need + 1)
        else
            false
        end
    end.

findIndexTime(Index, ChangeIndices, Limit) ->
    findIndexTimeHelper(Index, ChangeIndices, Limit, 1, -1).

findIndexTimeHelper(Index, ChangeIndices, Limit, Current, Result) ->
    if Current > Limit then
        Result
    else
        if lists:nth(Current, ChangeIndices) == Index then
            findIndexTimeHelper(Index, ChangeIndices, Limit, Current + 1, Current)
        else
            findIndexTimeHelper(Index, ChangeIndices, Limit, Current + 1, Result)
        end
    end.

for(Start, End, Step, Fun) ->
    for_helper(Start, End, Step, Fun).

for_helper(I, End, Step, Fun) ->
    if I > End then
        ok
    else
        Fun(I),
        for_helper(I + Step, End, Step, Fun)
    end.

-record(last_occurrences, {indices = []}).
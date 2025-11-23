-module(range_module).
-export([new/0, addRange/3, queryRange/3, removeRange/3]).

new() ->
    [].

addRange(Start, End, Ranges) ->
    %% Partition ranges into three groups:
    %% 1. Ranges completely before {Start, End}
    %% 2. Ranges overlapping {Start, End}
    %% 3. Ranges completely after {Start, End}

    {Before, Rest1} = lists:partition(fun({_, REnd}) -> REnd < Start end, Ranges),
    {Overlapping, After} = lists:partition(fun({RStart, _}) -> RStart =< End end, Rest1),

    %% Calculate the new merged range by combining {Start, End} with all overlapping ranges
    NewMergedRange = lists:foldl(
        fun({RStart, REnd}, {CurrentS, CurrentE}) ->
            {min(CurrentS, RStart), max(CurrentE, REnd)}
        end,
        {Start, End},
        Overlapping
    ),

    %% Reconstruct the list: Before ranges, then the NewMergedRange, then After ranges
    Before ++ [NewMergedRange] ++ After.

queryRange(Start, End, Ranges) ->
    %% Check if any existing range completely contains the queried range
    lists:any(fun({RStart, REnd}) -> RStart =< Start andalso REnd >= End end, Ranges).

removeRange(Start, End, Ranges) ->
    removeRange_impl(Start, End, Ranges, []).

removeRange_impl(_RemoveS, _RemoveE, [], Acc) ->
    lists:reverse(Acc);
removeRange_impl(RemoveS, RemoveE, [{RStart, REnd} | T], Acc) ->
    if
        %% Case 1: Current range is completely before the removal range
        REnd =< RemoveS ->
            removeRange_impl(RemoveS, RemoveE, T, [{RStart, REnd} | Acc]);
        %% Case 2: Current range is completely after the removal range
        RStart >= RemoveE ->
            removeRange_impl(RemoveS, RemoveE, T, [{RStart, REnd} | Acc]);
        %% Case 3: Current range is completely contained within the removal range
        %% It is removed, so do not add to accumulator
        RStart >= RemoveS andalso REnd =< RemoveE ->
            removeRange_impl(RemoveS, RemoveE, T, Acc);
        %% Case 4: Removal range is completely contained within current range (split current range)
        RStart < RemoveS andalso REnd > RemoveE ->
            Part1 = {RStart, RemoveS},
            Part2 = {RemoveE, REnd},
            %% Add parts in reverse order of appearance so lists:reverse puts them correctly
            removeRange_impl(RemoveS, RemoveE, T, [Part2, Part1 | Acc]);
        %% Case 5: Current range overlaps removal range's left end (keep left part)
        RStart < RemoveS andalso REnd > RemoveS andalso REnd <= RemoveE ->
            Part = {RStart, RemoveS},
            removeRange_impl(RemoveS, RemoveE, T, [Part | Acc]);
        %% Case 6: Current range overlaps removal range's right end (keep right part)
        RStart >= RemoveS andalso RStart < RemoveE andalso REnd > RemoveE ->
            Part = {RemoveE, REnd},
            removeRange_impl(RemoveS, RemoveE, T, [Part | Acc])
    end.
-module(solution).
-export([maximum_difference_after_k_operations/2]).

maximum_difference_after_k_operations(Gems, K) ->
    UpdatedGems = perform_operations(Gems, K),
    lists:max(UpdatedGems) - lists:min(UpdatedGems).

perform_operations(Gems, 0) -> Gems;
perform_operations(Gems, K) ->
    case find_min_max_indices(Gems) of
        {MinIdx, MaxIdx, MinVal, MaxVal} ->
            case should_break(MinVal, MaxVal) of
                true -> Gems;
                false ->
                    case select_source_dest(Gems, MinIdx, MaxIdx, MinVal, MaxVal) of
                        {SourceIdx, DestIdx} when is_integer(SourceIdx) ->
                            GemsToMove = (lists:nth(SourceIdx + 1, Gems)) div 2,
                            if GemsToMove == 0 ->
                                    Gems;
                                true ->
                                    NewGems = update_gems(Gems, SourceIdx, DestIdx, GemsToMove),
                                    perform_operations(NewGems, K - 1)
                            end;
                        _ -> % No valid source/dest found, or cannot make useful move
                            Gems
                    end
            end
    end.

find_min_max_indices(Gems) ->
    case Gems of
        [] -> {undefined, undefined, undefined, undefined};
        [H|T] ->
            find_min_max_indices_recursive(T, 0, 0, 0, H, H) % (List, CurrentIdx, MinIdx, MaxIdx, MinVal, MaxVal)
    end.

find_min_max_indices_recursive([], _CurrentIdx, MinIdx, MaxIdx, MinVal, MaxVal) ->
    {MinIdx, MaxIdx, MinVal, MaxVal};
find_min_max_indices_recursive([H|T], CurrentIdx, AccMinIdx, AccMaxIdx, AccMinVal, AccMaxVal) ->
    NewMinIdx = if H < AccMinVal -> CurrentIdx; true -> AccMinIdx end,
    NewMinVal = if H < AccMinVal -> H; true -> AccMinVal end,
    NewMaxIdx = if H > AccMaxVal -> CurrentIdx; true -> AccMaxIdx end,
    NewMaxVal = if H > AccMaxVal -> H; true -> AccMaxVal end,
    find_min_max_indices_recursive(T, CurrentIdx + 1, NewMinIdx, NewMaxIdx, NewMinVal, NewMaxVal).

should_break(MinVal, MaxVal) ->
    MinVal =< 1 andalso MaxVal =< 1.

select_source_dest(Gems, MinIdx, MaxIdx, MinVal, MaxVal) ->
    N = length(Gems),
    if
        MinVal > 1 -> % Case 1: MinVal is reducible
            if MinIdx == MaxIdx -> % All piles are equal, and > 1
                if N < 2 -> {undefined, undefined}; % Only one pile, no operation
                true -> {0, 1} % Pick first two distinct piles
                end;
            true -> % MinIdx and MaxIdx are different
                {MinIdx, MaxIdx}
            end;
        true -> % Case 2: MinVal <= 1 (not reducible)
            if MaxVal =< 1 -> % Should have been caught by should_break, but for safety
                {undefined, undefined};
            true -> % MaxVal > 1
                % Find the second largest pile to take gems from
                % To do this, we need to find all piles except MaxIdx, then find max among them
                FilteredGems = filter_out_at_index(Gems, MaxIdx),
                case find_max_val_and_idx_from_list(FilteredGems) of
                    {SecondMaxIdxInFiltered, SecondMaxVal} when is_integer(SecondMaxIdxInFiltered) ->
                        % Adjust SecondMaxIdxInFiltered to original index
                        ActualSecondMaxIdx = if SecondMaxIdxInFiltered >= MaxIdx -> SecondMaxIdxInFiltered + 1; true -> SecondMaxIdxInFiltered end,
                        if SecondMaxVal > 1 ->
                            {ActualSecondMaxIdx, MaxIdx};
                        true ->
                            {undefined, undefined} % Second largest is also <= 1, cannot make useful move
                        end;
                    _ -> % Only one pile (MaxIdx) or all others are empty/1
                        {undefined, undefined}
                end
            end
    end.

filter_out_at_index(List, IdxToFilter) ->
    filter_out_at_index(List, IdxToFilter, 0, []).

filter_out_at_index([], _IdxToFilter, _CurrentIdx, Acc) ->
    lists:reverse(Acc);
filter_out_at_index([H|T], IdxToFilter, CurrentIdx, Acc) ->
    if CurrentIdx == IdxToFilter ->
        filter_out_at_index(T, IdxToFilter, CurrentIdx + 1, Acc);
    true ->
        filter_out_at_index(T, IdxToFilter, CurrentIdx + 1, [H|Acc])
    end.

find_max_val_and_idx_from_list(List) ->
    case List of
        [] -> {undefined, undefined};
        [H|T] ->
            find_max_val_and_idx_from_list_recursive(T, 0, 0, H)
    end.

find_max_val_and_idx_from_list_recursive([], _CurrentIdx, AccMaxIdx, AccMaxVal) ->
    {AccMaxIdx, AccMaxVal};
find_max_val_and_idx_from_list_recursive([H|T], CurrentIdx, AccMaxIdx, AccMaxVal) ->
    NewMaxIdx = if H > AccMaxVal -> CurrentIdx; true -> AccMaxIdx end,
    NewMaxVal = if H > AccMaxVal -> H; true -> AccMaxVal end,
    find_max_val_and_idx_from_list_recursive(T, CurrentIdx + 1, NewMaxIdx, NewMaxVal).

update_gems(Gems, SourceIdx, DestIdx, GemsToMove) ->
    SourceVal = lists:nth(SourceIdx + 1, Gems),
    DestVal = lists:nth(DestIdx + 1, Gems),
    NewSourceVal = SourceVal - GemsToMove,
    NewDestVal = DestVal + GemsToMove,
    TempGems = set_nth(Gems, SourceIdx + 1, NewSourceVal),
    set_nth(TempGems, DestIdx + 1, NewDestVal).

set_nth(List, N, Value) ->
    set_nth_recursive(List, N, Value, 1, []).

set_nth_recursive([], _N, _Value, _CurrentIdx, Acc) ->
    lists:reverse(Acc);
set_nth_recursive([_H|T], N, Value, CurrentIdx, Acc) when CurrentIdx == N ->
    lists:reverse(Acc, [Value|T]);
set_nth_recursive([H|T], N, Value, CurrentIdx, Acc) ->
    set_nth_recursive(T, N, Value, CurrentIdx + 1, [H|Acc]).
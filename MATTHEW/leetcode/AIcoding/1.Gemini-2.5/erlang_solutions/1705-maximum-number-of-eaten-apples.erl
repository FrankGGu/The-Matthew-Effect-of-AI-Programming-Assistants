-module(solution).
-export([max_eaten_apples/2]).

list_to_array(List) ->
    array:from_list(List).

max_eaten_apples(ApplesList, DaysList) ->
    Apples = list_to_array(ApplesList),
    Days = list_to_array(DaysList),
    N = array:size(Apples),
    max_eaten_apples_impl(0, N, Apples, Days, gb_trees:empty(), 0).

max_eaten_apples_impl(Day, N, Apples, Days, Heap, EatenCount) when Day < N; not gb_trees:is_empty(Heap) ->
    NewHeap = 
        case Day < N of
            true ->
                ApplesToday = array:get(Day, Apples),
                DaysToRot = array:get(Day, Days),
                if ApplesToday > 0 ->
                    RottingDay = Day + DaysToRot,
                    gb_trees:insert({RottingDay, Day}, ApplesToday, Heap);
                true ->
                    Heap
                end;
            false ->
                Heap
        end,

    CleanedHeap = clean_rotten_apples(Day, NewHeap),

    case gb_trees:is_empty(CleanedHeap) of
        true ->
            max_eaten_apples_impl(Day + 1, N, Apples, Days, CleanedHeap, EatenCount);
        false ->
            {{RottingDay, OriginalIndex}, Count} = gb_trees:smallest(CleanedHeap),

            UpdatedHeap = 
                if Count == 1 ->
                    gb_trees:delete({RottingDay, OriginalIndex}, CleanedHeap);
                true ->
                    gb_trees:update({RottingDay, OriginalIndex}, Count - 1, CleanedHeap)
                end,

            max_eaten_apples_impl(Day + 1, N, Apples, Days, UpdatedHeap, EatenCount + 1)
    end;
max_eaten_apples_impl(_Day, _N, _Apples, _Days, _Heap, EatenCount) ->
    EatenCount.

clean_rotten_apples(CurrentDay, Heap) ->
    case gb_trees:is_empty(Heap) of
        true ->
            Heap;
        false ->
            {{RottingDay, _OriginalIndex}, _Count} = gb_trees:smallest(Heap),
            if RottingDay =< CurrentDay ->
                {_Key, _Value, RemainingHeap} = gb_trees:delete_smallest(Heap),
                clean_rotten_apples(CurrentDay, RemainingHeap);
            true ->
                Heap
            end
    end.
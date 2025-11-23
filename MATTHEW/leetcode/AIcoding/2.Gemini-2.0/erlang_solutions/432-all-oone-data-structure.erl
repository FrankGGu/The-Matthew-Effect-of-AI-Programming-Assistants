-module(all_one).
-export([new/0, inc/2, dec/2, getMaxKey/1, getMinKey/1]).

-record(state, {
    key_to_count = dict:new(),
    count_to_keys = dict:new(),
    min_count = undefined,
    max_count = undefined
}).

new() ->
    #state{}.

inc(Key, State) ->
    Count = dict:fetch(Key, State#state.key_to_count, 0),
    NewCount = Count + 1,

    State1 = case Count of
        0 ->
            State
        _ ->
            Keys = dict:fetch(Count, State#state.count_to_keys),
            NewKeys = lists:delete(Key, Keys),
            State2 = dict:store(Count, NewKeys, State#state.count_to_keys),
            State3 = case NewKeys of
                [] ->
                    dict:erase(Count, State2#state.count_to_keys)
                _ ->
                    State2
            end,
            update_min_max(State3, Count)
    end,

    Keys1 = dict:fetch(NewCount, State1#state.count_to_keys, []),
    NewKeys1 = [Key | Keys1],
    State4 = dict:store(NewCount, NewKeys1, State1#state.count_to_keys),
    State5 = dict:store(Key, NewCount, State4#state.key_to_count),
    update_min_max(State5, NewCount).

dec(Key, State) ->
    Count = dict:fetch(Key, State#state.key_to_count),
    NewCount = Count - 1,

    Keys = dict:fetch(Count, State#state.count_to_keys),
    NewKeys = lists:delete(Key, Keys),
    State1 = dict:store(Count, NewKeys, State#state.count_to_keys),
    State2 = case NewKeys of
        [] ->
            dict:erase(Count, State1#state.count_to_keys)
        _ ->
            State1
    end,
    State3 = dict:erase(Key, State2#state.key_to_count),
    State4 = update_min_max(State2, Count),

    State5 = case NewCount of
        0 ->
            State3
        _ ->
            Keys1 = dict:fetch(NewCount, State3#state.count_to_keys, []),
            NewKeys1 = [Key | Keys1],
            State6 = dict:store(NewCount, NewKeys1, State3#state.count_to_keys),
            State7 = dict:store(Key, NewCount, State6#state.key_to_count),
            update_min_max(State7, NewCount)
    end,

    if NewCount == 0 ->
        State5
    else
        State5
    end.

getMaxKey(State) ->
    case State#state.max_count of
        undefined ->
            ""
        Count ->
            Keys = dict:fetch(Count, State#state.count_to_keys),
            case Keys of
                [] ->
                    ""
                _ ->
                    lists:nth(1, Keys)
            end
    end.

getMinKey(State) ->
    case State#state.min_count of
        undefined ->
            ""
        Count ->
            Keys = dict:fetch(Count, State#state.count_to_keys),
            case Keys of
                [] ->
                    ""
                _ ->
                    lists:nth(1, Keys)
            end
    end.

update_min_max(State, Count) ->
    MinCount = State#state.min_count,
    MaxCount = State#state.max_count,

    NewMinCount = case MinCount of
        undefined ->
            Count
        _ ->
            case dict:fetch(MinCount, State#state.count_to_keys, []) of
                [] ->
                    find_next_min(State, Count)
                _ ->
                    MinCount
            end
    end,

    NewMaxCount = case MaxCount of
        undefined ->
            Count
        _ ->
            case dict:fetch(MaxCount, State#state.count_to_keys, []) of
                [] ->
                    find_next_max(State, Count)
                _ ->
                    MaxCount
            end
    end,

    State#state{min_count = NewMinCount, max_count = NewMaxCount}.

find_next_min(State, Start) ->
    Counts = dict:keys(State#state.count_to_keys),
    case Counts of
        [] ->
            undefined
        _ ->
            FilteredCounts = lists:filter(fun(C) -> C >= Start end, Counts),
            case FilteredCounts of
                [] ->
                    undefined
                _ ->
                    lists:min(FilteredCounts)
            end
    end.

find_next_max(State, Start) ->
    Counts = dict:keys(State#state.count_to_keys),
    case Counts of
        [] ->
            undefined
        _ ->
            FilteredCounts = lists:filter(fun(C) -> C =< Start end, Counts),
            case FilteredCounts of
                [] ->
                    undefined
                _ ->
                    lists:max(FilteredCounts)
            end
    end.
-module(solution).
-export([
    all_one_init_/0,
    all_one_inc/1,
    all_one_dec/1,
    all_one_get_max_key/0,
    all_one_get_min_key/0
]).

%% È«¾Ö×´Ì¬´æ´¢
-define(TABLE, all_one_state).

-record(state, {
    key_map = #{} :: map(),          %% Key => Count
    count_map = #{} :: map(),        %% Count => sets of Keys
    min_count = 0 :: integer(),
    max_count = 0 :: integer()
}).

-spec all_one_init_() -> any().
all_one_init_() ->
    State = #state{},
    put(?TABLE, State).

-spec all_one_inc(binary()) -> any().
all_one_inc(Key) ->
    State = get(?TABLE),
    KeyMap = State#state.key_map,
    CMap = State#state.count_map,
    Count = maps:get(Key, KeyMap, 0),
    NewCount = Count + 1,
    NewKeyMap = maps:put(Key, NewCount, KeyMap),

    %% Remove from old count group
    CMap1 = case Count of
        0 -> CMap;
        _ ->
            OldSet = maps:get(Count, CMap),
            NewSet = sets:del_element(Key, OldSet),
            case sets:is_empty(NewSet) of
                true -> maps:remove(Count, CMap);
                false -> maps:put(Count, NewSet, CMap)
            end
    end,

    %% Add to new count group
    Set1 = maps:get(NewCount, CMap1, sets:new()),
    Set2 = sets:add_element(Key, Set1),
    NewCMap = maps:put(NewCount, Set2, CMap1),

    MinC = case State#state.min_count of
        0 -> NewCount;
        M when NewCount < M -> NewCount;
        M -> if Count == M andalso not maps:is_key(Count, NewCMap) -> NewCount;
                 true -> M
             end
    end,

    MaxC = max(NewCount, State#state.max_count),

    NewState = State#state{
        key_map = NewKeyMap,
        count_map = NewCMap,
        min_count = MinC,
        max_count = MaxC
    },
    put(?TABLE, NewState).

-spec all_one_dec(binary()) -> any().
all_one_dec(Key) ->
    State = get(?TABLE),
    KeyMap = State#state.key_map,
    Count = maps:get(Key, KeyMap),
    NewCount = Count - 1,
    NewKeyMap = if
        NewCount == 0 -> maps:remove(Key, KeyMap);
        true -> maps:put(Key, NewCount, KeyMap)
    end,

    %% Remove from current count set
    CMap = State#state.count_map,
    OldSet = maps:get(Count, CMap),
    NewSet = sets:del_element(Key, OldSet),
    CMap1 = if
        sets:is_empty(NewSet) -> maps:remove(Count, CMap);
        true -> maps:put(Count, NewSet, CMap)
    end,

    %% Add to lower count if > 0
    CMap2 = if
        NewCount == 0 -> CMap1;
        true ->
            S = maps:get(NewCount, CMap1, sets:new()),
            maps:put(NewCount, sets:add_element(Key, S), CMap1)
    end,

    %% Update min/max
    NewMin = case maps:is_key(State#state.min_count, CMap2) of
        true -> State#state.min_count;
        false -> find_min_count(CMap2)
    end,
    NewMax = case maps:is_key(State#state.max_count, CMap2) of
        true -> State#state.max_count;
        false -> find_max_count(CMap2)
    end,

    NewState = State#state{
        key_map = NewKeyMap,
        count_map = CMap2,
        min_count = NewMin,
        max_count = NewMax
    },
    put(?TABLE, NewState).

-spec all_one_get_max_key() -> binary().
all_one_get_max_key() ->
    State = get(?TABLE),
    Max = State#state.max_count,
    case maps:find(Max, State#state.count_map) of
        error -> <<"">>;
        {ok, Set} ->
            case sets:to_list(Set) of
                [] -> <<"">>;
                [H|_] -> H
            end
    end.

-spec all_one_get_min_key() -> binary().
all_one_get_min_key() ->
    State = get(?TABLE),
    Min = State#state.min_count,
    case maps:find(Min, State#state.count_map) of
        error -> <<"">>;
        {ok, Set} ->
            case sets:to_list(Set) of
                [] -> <<"">>;
                [H|_] -> H
            end
    end.

find_min_count(Map) ->
    Keys = maps:keys(Map),
    case Keys of
        [] -> 0;
        _ -> lists:min(Keys)
    end.

find_max_count(Map) ->
    Keys = maps:keys(Map),
    case Keys of
        [] -> 0;
        _ -> lists:max(Keys)
    end.

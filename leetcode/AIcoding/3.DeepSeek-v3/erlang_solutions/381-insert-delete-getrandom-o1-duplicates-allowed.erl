-module(randomized_collection).

-export([init/0, insert/1, remove/1, get_random/0]).

-record(state, {
    list = [],
    map = #{}
}).

init() ->
    #state{}.

insert(Val) ->
    State = get(),
    List = State#state.list,
    Map = State#state.map,
    case maps:find(Val, Map) of
        {ok, Indices} ->
            NewIndices = [length(List) | Indices],
            NewMap = maps:put(Val, NewIndices, Map),
            NewList = List ++ [Val],
            put(State#state{list = NewList, map = NewMap}),
            false;
        error ->
            NewMap = maps:put(Val, [length(List)], Map),
            NewList = List ++ [Val],
            put(State#state{list = NewList, map = NewMap}),
            true
    end.

remove(Val) ->
    State = get(),
    List = State#state.list,
    Map = State#state.map,
    case maps:find(Val, Map) of
        {ok, [LastIdx | RestIndices]} ->
            LastVal = lists:nth(LastIdx + 1, List),
            NewList = case LastIdx =:= length(List) - 1 of
                true ->
                    lists:sublist(List, length(List) - 1);
                false ->
                    {List1, [_ | List2]} = lists:split(LastIdx, List),
                    List1 ++ [LastVal | List2]
            end,
            NewMap = case RestIndices of
                [] ->
                    maps:remove(Val, Map);
                _ ->
                    maps:put(Val, RestIndices, Map)
            end,
            case Val =/= LastVal of
                true ->
                    {ok, Indices} = maps:find(LastVal, NewMap),
                    UpdatedIndices = lists:sort([LastIdx | lists:delete(length(List) - 1, Indices)]),
                    FinalMap = maps:put(LastVal, UpdatedIndices, NewMap),
                    put(State#state{list = NewList, map = FinalMap});
                false ->
                    put(State#state{list = NewList, map = NewMap})
            end,
            true;
        error ->
            false
    end.

get_random() ->
    State = get(),
    List = State#state.list,
    Index = rand:uniform(length(List)) - 1,
    lists:nth(Index + 1, List).
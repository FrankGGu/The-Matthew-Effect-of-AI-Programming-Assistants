-module(randomized_set).

-export([init/0, insert/1, remove/1, getRandom/0]).

-record(state, {map = dict:new(), list = []}).

init() ->
    {ok, #state{}}.

insert(Val) ->
    {ok, State} = get();
    case dict:is_key(Val, State#state.map) of
        true ->
            {ok, State};
        false ->
            NewList = State#state.list ++ [Val],
            NewMap = dict:store(Val, length(NewList) - 1, State#state.map),
            put({state, #state{map = NewMap, list = NewList}}),
            {ok, State}
    end.

remove(Val) ->
    {ok, State} = get();
    case dict:is_key(Val, State#state.map) of
        true ->
            Index = dict:fetch(Val, State#state.map),
            NewList = case length(State#state.list) of
                1 ->
                    [];
                _ ->
                    LastElement = lists:last(State#state.list),
                    case Val == LastElement of
                        true ->
                            lists:sublist(State#state.list, 1, length(State#state.list) - 1);
                        false ->
                            NewList1 = lists:sublist(State#state.list, 1, Index) ++ lists:sublist(State#state.list, Index + 2, length(State#state.list) - Index - 1),
                            NewList1
                    end
            end,
            NewMap = dict:erase(Val, State#state.map),
            case NewList of
                [] ->
                    put({state, #state{map = NewMap, list = NewList}});
                _ ->
                    LastElement = lists:last(State#state.list),
                    case Val == LastElement of
                        true ->
                            put({state, #state{map = NewMap, list = NewList}});
                        false ->
                            LastElementIndex = dict:fetch(LastElement, State#state.map),
                            NewMap2 = dict:store(LastElement, Index, NewMap),
                            put({state, #state{map = NewMap2, list = NewList}})
                    end
            end,
            {ok, State};
        false ->
            {ok, State}
    end.

getRandom() ->
    {ok, State} = get();
    List = State#state.list,
    case length(List) of
        0 ->
            null;
        _ ->
            Index = rand:uniform(length(List)) - 1,
            lists:nth(Index + 1, List)
    end.

get() ->
    case get({state}) of
        undefined ->
            {ok, #state{}};
        State ->
            {ok, State#state}
    end.
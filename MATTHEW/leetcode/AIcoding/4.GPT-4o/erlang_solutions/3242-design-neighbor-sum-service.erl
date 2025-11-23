-module(NeighborSum).
-export([new/0, lookup/1, add/2]).

-record(state, {map = #{}}).

new() ->
    fun() ->
        State = #state{},
        fun(Action) ->
            case Action of
                {lookup, id} ->
                    maps:get(id, State#state.map, 0);
                {add, id, value} ->
                    NewMap = maps:update_with(id, fun(X) -> X + value end, value, State#state.map),
                    State1 = State#state{map = NewMap},
                    State1
            end
        end
    end.
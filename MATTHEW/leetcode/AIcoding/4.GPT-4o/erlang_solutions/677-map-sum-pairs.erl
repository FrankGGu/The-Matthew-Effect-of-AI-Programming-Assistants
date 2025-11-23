-module(map_sum).
-export([new/0, insert/3, sum/2]).

-record(state, {map = #{}}).

new() ->
    #state{}.

insert(State, Key, Value) ->
    NewMap = maps:put(Key, Value, State#state.map),
    #state{map = NewMap}.

sum(State, Prefix) ->
    Maps = maps:to_list(State#state.map),
    lists:foldl(fun({K, V}, Acc) ->
        case string:prefix(K, Prefix) of
            true -> Acc + V;
            false -> Acc
        end
    end, 0, Maps).
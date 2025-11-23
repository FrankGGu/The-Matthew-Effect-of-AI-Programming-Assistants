-module(RandomizedSet).
-export([new/0, insert/2, remove/2, getRandom/1]).

-record(state, {map = #{}, list = [], rand_gen}).

new() ->
    {ok, #state{rand_gen = random:seed()} }.

insert(#state{map = M, list = L, rand_gen = R} = State, Value) ->
    case maps:is_key(Value, M) of
        true -> {State, false};
        false ->
            NewMap = maps:put(Value, length(L), M),
            NewList = L ++ [Value],
            {ok, #state{map = NewMap, list = NewList, rand_gen = R}, true}
    end.

remove(#state{map = M, list = L, rand_gen = R} = State, Value) ->
    case maps:is_key(Value, M) of
        false -> {State, false};
        true ->
            {Index, _} = maps:find(Value, M),
            Last = lists:last(L),
            NewList = lists:delete(Value, L),
            NewMap = maps:remove(Value, M),
            NewMap2 = if Index == (length(L) - 1) -> NewMap; true -> maps:put(Last, Index, NewMap) end,
            {ok, #state{map = NewMap2, list = NewList, rand_gen = R}, true}
    end.

getRandom(#state{list = L, rand_gen = R}) ->
    {ok, RandomIndex} = random:uniform(length(L)),
    lists:nth(RandomIndex, L).
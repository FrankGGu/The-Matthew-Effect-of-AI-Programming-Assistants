-module(randomized_set).
-export([init/0, insert/2, remove/2, get_random/1]).

-record(rs_state, {
    map = #{} :: map(),      % val -> index in list
    list = array:new() :: array:array(), % stores values
    size = 0 :: non_neg_integer() % current number of elements
}).

init() ->
    rand:seed(erlang:phash2({node(), self(), make_ref()})),
    #rs_state{}.

insert(Val, #rs_state{map = Map, list = List, size = Size} = State) ->
    case maps:is_key(Val, Map) of
        true ->
            {false, State};
        false ->
            NewMap = maps:put(Val, Size, Map),
            NewList = array:set(Size, Val, List),
            NewSize = Size + 1,
            {true, State#rs_state{map = NewMap, list = NewList, size = NewSize}}
    end.

remove(Val, #rs_state{map = Map, list = List, size = Size} = State) ->
    case maps:is_key(Val, Map) of
        false ->
            {false, State};
        true ->
            IndexToRemove = maps:get(Val, Map),
            LastIndex = Size - 1,
            NewMap = maps:remove(Val, Map),

            if IndexToRemove == LastIndex ->
                NewSize = Size - 1,
                {true, State#rs_state{map = NewMap, size = NewSize}};
            else ->
                LastVal = array:get(LastIndex, List),
                NewList = array:set(IndexToRemove, LastVal, List),
                NewMapWithUpdatedLastVal = maps:put(LastVal, IndexToRemove, NewMap),
                NewSize = Size - 1,
                {true, State#rs_state{map = NewMapWithUpdatedLastVal, list = NewList, size = NewSize}}
            end
    end.

get_random(#rs_state{list = List, size = Size}) ->
    RandomIndex = rand:uniform(Size) - 1,
    array:get(RandomIndex, List).
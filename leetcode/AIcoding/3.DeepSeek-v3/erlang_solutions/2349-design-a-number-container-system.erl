-module(number_containers).
-export([init/0, change/3, find/2]).

-record(state, {index_to_num = #{}, num_to_indices = #{}}).

init() ->
    #state{}.

change(State, Index, Number) ->
    OldNum = maps:get(Index, State#state.index_to_num, undefined),
    NewIndexToNum = State#state.index_to_num#{Index => Number},
    NewNumToIndices = case OldNum of
        undefined ->
            Indices = maps:get(Number, State#state.num_to_indices, sets:new()),
            State#state.num_to_indices#{Number => sets:add_element(Index, Indices)};
        OldNum ->
            Indices1 = sets:del_element(Index, maps:get(OldNum, State#state.num_to_indices)),
            NumToIndices1 = case sets:size(Indices1) of
                0 -> maps:remove(OldNum, State#state.num_to_indices);
                _ -> State#state.num_to_indices#{OldNum => Indices1}
            end,
            Indices2 = maps:get(Number, NumToIndices1, sets:new()),
            NumToIndices1#{Number => sets:add_element(Index, Indices2)}
    end,
    #state{index_to_num = NewIndexToNum, num_to_indices = NewNumToIndices}.

find(State, Number) ->
    case maps:get(Number, State#state.num_to_indices, undefined) of
        undefined -> -1;
        Indices ->
            case sets:is_empty(Indices) of
                true -> -1;
                false -> sets:min(Indices)
            end
    end.
-module(consecutive).
-export([init/0, consec/3]).

-record(state, {value, count}).

init() ->
    #state{value = undefined, count = 0}.

consec(Value, K, State) ->
    case State#state.value of
        Value ->
            NewCount = State#state.count + 1,
            NewState = State#state{count = NewCount},
            NewCount >= K;
        _ ->
            NewState = State#state{value = Value, count = 1},
            K =:= 1
    end.
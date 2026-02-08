-module(CustomStack).
-export([new/1, push/2, pop/1, increment/3]).

-record(state, {stack = [], max_size}).

new(MaxSize) ->
    #state{max_size = MaxSize}.

push(State, X) ->
    case length(State#state.stack) < State#state.max_size of
        true -> 
            NewStack = [X | State#state.stack],
            #state{State | stack = NewStack};
        false -> 
            State
    end.

pop(State) ->
    case State#state.stack of
        [] -> 
            -1;
        [H | T] -> 
            {H, #state{State | stack = T}}
    end.

increment(State, K, X) ->
    NewStack = lists:map(fun(N, I) -> 
        case I < K of 
            true -> N + X; 
            false -> N 
        end 
    end, State#state.stack, lists:seq(1, length(State#state.stack))),
    #state{State | stack = NewStack}.
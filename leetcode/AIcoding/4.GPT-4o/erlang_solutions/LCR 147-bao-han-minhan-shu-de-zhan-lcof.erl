-module(min_stack).
-export([new/0, push/2, pop/1, top/1, get_min/1]).

-record(state, {stack = [], min_stack = []}).

new() ->
    #state{}.

push(State, X) ->
    MinStack = case State#state.min_stack of
        [] -> [X];
        [Min | _] when X < Min -> [X];
        MinStack -> [hd(MinStack)]
    end,
    #state{stack = [X | State#state.stack], min_stack = MinStack}.

pop(State) ->
    case State#state.stack of
        [] -> State;
        [_ | Rest] -> 
            MinStack = case State#state.min_stack of
                [] -> [];
                [Min | MinRest] -> 
                    case Rest of
                        [] -> [];
                        [H | _] when H == Min -> MinRest;
                        _ -> [Min]
                    end
            end,
            #state{stack = Rest, min_stack = MinStack}
    end.

top(State) ->
    case State#state.stack of
        [] -> undefined;
        [Top | _] -> Top
    end.

get_min(State) ->
    case State#state.min_stack of
        [] -> undefined;
        [Min | _] -> Min
    end.
-module(bst_iterator).

-export([new/1, hasNext/1, next/1]).

-record(state, {stack :: list()}).

new(Root) ->
    State = #state{stack = []},
    pushLeft(Root, State).

hasNext(#state{stack = []}) ->
    false;
hasNext(_) ->
    true.

next(State) ->
    {Node, NewState} = pop(State),
    Value = element(1, Node),
    NewNewState = pushLeft(element(3, Node), NewState),
    {Value, NewNewState}.

pushLeft(null, State) ->
    State;
pushLeft(Node, #state{stack = Stack} = State0) ->
    NewStack = [Node | Stack],
    pushLeft(element(2, Node), State0#state{stack = NewStack}).

pop(#state{stack = [Node | Rest]} = State) ->
    {Node, State#state{stack = Rest}}.
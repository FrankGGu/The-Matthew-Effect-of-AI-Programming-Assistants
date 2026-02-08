-module(browser_history).
-export([new/1, visit/2, back/2, forward/2]).

-record(state, {history = [], future = []}).

new(homepage) ->
    #state{history = [homepage], future = []}.

visit(URL, State) ->
    #state{history = [URL], future = []}#state{State, history = [hd(State#state.history) | State#state.history], future = []}.

back(Steps, State) ->
    {NewHistory, NewFuture, RemainingSteps} = back_helper(Steps, State#state.history, State#state.future, []),

    if RemainingSteps > 0 ->
        {hd(State#state.history), State}
    else
        NewState = #state{history = NewHistory, future = [hd(State#state.history) | NewFuture]},
        {hd(NewHistory), NewState}
    end.

back_helper(0, History, Future, Acc) ->
    {History, Future, 0};
back_helper(_Steps, [H], Future, Acc) ->
    {[H], Future, _Steps};
back_helper(Steps, [H|T], Future, Acc) ->
    back_helper(Steps - 1, T, [H | Future], Acc).

forward(Steps, State) ->
    {NewHistory, NewFuture, RemainingSteps} = forward_helper(Steps, State#state.future, State#state.history, []),

    if RemainingSteps > 0 ->
        {hd(State#state.history), State}
    else
        NewState = #state{history = [hd(State#state.future) | State#state.history], future = NewFuture},
        {hd(NewState#state.history), NewState}
    end.

forward_helper(0, Future, History, Acc) ->
    {History, Future, 0};
forward_helper(_Steps, [], History, Acc) ->
    {History, [], _Steps};
forward_helper(Steps, [H|T], History, Acc) ->
    forward_helper(Steps - 1, T, [H | History], Acc).
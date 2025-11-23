-module(SelfCheckout).
-export([new/0, scan/2, total/1, clear/1]).

-record(state, {items = []}).

new() ->
    #state{}.

scan(Item, State) ->
    Items = State#state.items,
    NewItems = [Item | Items],
    State#state{items = NewItems}.

total(State) ->
    Items = State#state.items,
    lists:sum(Items).

clear(State) ->
    State#state{items = []}.
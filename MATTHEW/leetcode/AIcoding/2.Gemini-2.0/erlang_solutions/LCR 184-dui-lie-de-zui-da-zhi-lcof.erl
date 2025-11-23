-module(checkout).
-export([start/0, checkout/2, scan/2, remove/2, get_bill/1]).

-record(state, {items = dict:new(), prices = dict:new()}).

start() ->
    {ok, spawn_link(fun() -> loop(#state{}) end)}.

checkout(Pid, Prices) ->
    Pid ! {set_prices, Prices},
    receive
        {Pid, ok} -> ok
    end.

scan(Pid, Item) ->
    Pid ! {scan_item, Item},
    receive
        {Pid, ok} -> ok
    end.

remove(Pid, Item) ->
    Pid ! {remove_item, Item},
    receive
        {Pid, ok} -> ok
    end.

get_bill(Pid) ->
    Pid ! get_total,
    receive
        {Pid, Total} -> Total
    end.

loop(State) ->
    receive
        {set_prices, Prices} ->
            NewState = State#state{prices = dict:from_list(Prices)},
            loop(NewState);
        {scan_item, Item} ->
            NewItems = dict:update_counter(Item, 1, State#state.items),
            NewState = State#state{items = NewItems},
            reply(ok);
        {remove_item, Item} ->
            case dict:find(Item, State#state.items) of
                {ok, Count} ->
                    if
                        Count > 1 ->
                            NewItems = dict:update(Item, Count - 1, State#state.items),
                            NewState = State#state{items = NewItems};
                        true ->
                            NewItems = dict:erase(Item, State#state.items),
                            NewState = State#state{items = NewItems}
                    end,
                    reply(ok);
                error ->
                    reply(ok)
            end,
            loop(NewState);
        get_total ->
            Total = calculate_total(State#state.items, State#state.prices),
            reply(Total),
            loop(State);
        _ ->
            loop(State)
    end.

calculate_total(Items, Prices) ->
    dict:fold(fun(Item, Count, Acc) ->
                      case dict:find(Item, Prices) of
                          {ok, Price} ->
                              Acc + Price * Count;
                          error ->
                              Acc
                      end
              end, 0, Items).

reply(Msg) ->
    Sender = self(),
    Sender ! {self(), Msg}.
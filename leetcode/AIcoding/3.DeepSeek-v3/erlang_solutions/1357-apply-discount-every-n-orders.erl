-module(shopping).
-export([init/3, get_bill/2]).

-record(state, {n, current, discount, products}).

init(N, Discount, Products) ->
    {ok, #state{n=N, current=0, discount=Discount, products=Products}}.

get_bill(State, Product, Amount) ->
    #state{n=N, current=Current, discount=Discount, products=Products} = State,
    Price = maps:get(Product, Products),
    Total = Price * Amount,
    NewCurrent = Current + 1,
    NewState = State#state{current=NewCurrent},
    case NewCurrent rem N of
        0 ->
            {Total - (Total * Discount) div 100, NewState};
        _ ->
            {Total, NewState}
    end.
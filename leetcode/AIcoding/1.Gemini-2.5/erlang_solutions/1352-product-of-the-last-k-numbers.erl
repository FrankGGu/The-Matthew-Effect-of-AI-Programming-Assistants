-module(product_of_numbers).
-export([new/0, add/2, get_product/2]).

-record(state, {products :: array:array(), size :: non_neg_integer()}).

new() ->
    #state{products = array:from_list([1]), size = 0}.

add(Val, #state{products = Arr, size = Size} = State) ->
    LastProduct = array:get(Size, Arr),
    NewProduct = LastProduct * Val,
    NewArr = array:set(Size + 1, NewProduct, Arr),
    State#state{products = NewArr, size = Size + 1}.

get_product(K, #state{products = Arr, size = Size}) ->
    PN = array:get(Size, Arr),
    PN_K = array:get(Size - K, Arr),
    PN div PN_K.
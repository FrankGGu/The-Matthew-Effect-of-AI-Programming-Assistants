-module(ProductOfLastKNumbers).
-export([ProductOfNumbers/0, add/1, getProduct/0]).

-record(state, {nums = [], product = 1}).

ProductOfNumbers() ->
    fun() ->
        fun
            add(X) ->
                NewNums = [X | lists:sublist(State#state.nums, 0, K)],
                NewProduct = lists:foldl(fun(N, Acc) -> Acc * N end, 1, NewNums),
                State = #state{nums = NewNums, product = NewProduct},
                ok;
            getProduct() ->
                State#state.product
        end
    end.

K = 3.
-module(kth_largest).
-export([init/2, add/2]).

-record(state, {k, nums}).

init(K, Nums) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    #state{k=K, nums=lists:sublist(Sorted, K)}.

add(Val, #state{k=K, nums=Nums}=State) ->
    NewNums = lists:sort(fun(A, B) -> A >= B end, [Val | Nums]),
    Kth = lists:nth(K, NewNums),
    {Kth, State#state{nums=lists:sublist(NewNums, K)}}.
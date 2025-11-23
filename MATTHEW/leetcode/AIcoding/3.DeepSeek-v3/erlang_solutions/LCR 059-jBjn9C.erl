-module(kth_largest).
-export([init/2, add/2]).

-record(state, {k, pq}).

init(K, Nums) ->
    PQ = lists:foldl(fun(N, Q) -> pq:in(N, Q) end, pq:new(), Nums),
    #state{k = K, pq = PQ}.

add(Val, #state{k = K, pq = PQ} = State) ->
    NewPQ = pq:in(Val, PQ),
    TrimmedPQ = trim(NewPQ, K),
    {Top, _} = pq:peek(TrimmedPQ),
    {Top, State#state{pq = TrimmedPQ}}.

trim(PQ, K) ->
    case pq:size(PQ) of
        Size when Size > K ->
            {_, NewPQ} = pq:out(PQ),
            trim(NewPQ, K);
        _ ->
            PQ
    end.
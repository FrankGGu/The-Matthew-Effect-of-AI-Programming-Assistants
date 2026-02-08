-module(solution).
-export([network_becomes_idle/2]).

build_adj(N, Times) ->
    Adj = array:new([{size, N}, {fixed, true}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
        Adj1 = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, [U | array:get(V, Adj1)], Adj1)
    end, Adj, Times).

bfs_loop(Q, Dist, Adj) when queue:is_empty(Q) -> Dist;
bfs_loop(Q, Dist, Adj) ->
    {{value, U}, Q1} = queue:out(Q),
    D_U = array:get(U, Dist),
    Neighbors = array:get(U, Adj),
    {Q2, Dist2} = lists:foldl(fun(V, {AccQ, AccDist}) ->
        case array:get(V, AccDist) of
            -1 ->
                NewDist = array:set(V, D_U + 1, AccDist),
                {queue:in(V, AccQ), NewDist};
            _ ->
                {AccQ, AccDist}
        end
    end, {Q1, Dist}, Neighbors),
    bfs_loop(Q2, Dist2, Adj).

bfs(N, Adj) ->
    Dist = array:new([{size, N}, {fixed, true}, {default, -1}]),
    Dist0 = array:set(0, 0, Dist),
    Queue = queue:new(),
    Queue0 = queue:in(0, Queue),
    bfs_loop(Queue0, Dist0, Adj).

network_becomes_idle(Times, PatienceList) ->
    N = length(PatienceList),
    Adj = build_adj(N, Times),
    Distances = bfs(N, Adj),
    PatienceArray = array:from_list(PatienceList),

    MaxIdleTime = lists:foldl(fun(I, AccMaxIdle) ->
        D_I = array:get(I, Distances),

        RoundTripTime = 2 * D_I,
        P_I = array:get(I, PatienceArray),

        LastSendTime = 
            if RoundTripTime =< P_I -> 0;
               true -> ((RoundTripTime - 1) div P_I) * P_I
            end,

        CurrentIdleTime = LastSendTime + RoundTripTime,
        erlang:max(AccMaxIdle, CurrentIdleTime)
    end, 0, lists:seq(1, N - 1)),

    MaxIdleTime + 1.
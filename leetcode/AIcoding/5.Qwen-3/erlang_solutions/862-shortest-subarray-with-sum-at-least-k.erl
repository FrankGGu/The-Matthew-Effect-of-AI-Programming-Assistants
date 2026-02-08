-module(solution).
-export([shortestSubarray/2]).

shortestSubarray(Nums, K) ->
    N = length(Nums),
    Prefix = lists:seq(0, N),
    lists:foldl(fun(I, Acc) -> 
        lists:put(0, lists:nth(I, Nums) + lists:nth(0, Acc), Acc)
    end, [0], lists:seq(1, N)),
    Deque = queue:new(),
    MinLen = infinity,
    lists:foreach(fun(I) ->
        while Deque /= queue:empty() andalso lists:nth(I, Prefix) - lists:nth(queue:front(Deque), Prefix) >= K do
            MinLen = min(MinLen, I - queue:front(Deque)),
            Deque = queue:drop(Deque)
        end,
        while Deque /= queue:empty() andalso lists:nth(I, Prefix) <= lists:nth(queue:back(Deque), Prefix) do
            Deque = queue:drop(Deque)
        end,
        Deque = queue:in(I, Deque)
    end, lists:seq(0, N)),
    if MinLen == infinity -> -1; true -> MinLen end.
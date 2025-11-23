-module(allocate_mailboxes).
-export([min_distance/1]).

min_distance(Houses) ->
    N = length(Houses),
    lists:sort(Houses, fun(A, B) -> A < B end) ->
    Memo = dict:new(),
    min_distance_helper(Houses, 1, N, 1, Memo).

min_distance_helper(Houses, K, N, I, Memo) ->
    case dict:find( {K, I, N}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Result = min_distance_calc(Houses, K, N, I, Memo),
            dict:store({K, I, N}, Result, Memo),
            Result
    end.

min_distance_calc(Houses, K, N, I, Memo) ->
    if K == 1 then
        cost(Houses, I, N)
    else
        lists:foldl(fun(J, Acc) ->
                         MinDistance = min_distance_helper(Houses, K - 1, J - 1, I, Memo) + cost(Houses, J, N),
                         min(Acc, MinDistance)
                 end,
                 infinity,
                 lists:seq(I + K - 1, N - 1))
    end.

cost(Houses, I, N) ->
    Mid = (I + N) div 2,
    Median = lists:nth(Mid, Houses),
    lists:foldl(fun(Idx, Acc) ->
                         Acc + abs(lists:nth(Idx, Houses) - Median)
                 end,
                 0,
                 lists:seq(I, N)).

infinity() -> 1000000000.
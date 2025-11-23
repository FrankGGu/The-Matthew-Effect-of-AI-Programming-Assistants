-module(solution).
-export([max_sum/2]).

max_sum(K, A) ->
    max_sum(K, A, 0, 0, dict:new(), 0).

max_sum(K, [H | T], Sum, MaxSum, Seen, Count) when Count < K ->
    NewSeen = dict:store(H, true, Seen),
    max_sum(K, T, Sum + H, MaxSum, NewSeen, Count + 1);
max_sum(K, [_ | T], Sum, MaxSum, Seen, K) ->
    MaxSum1 = max(MaxSum, Sum),
    case T of
        [] -> MaxSum1;
        [H | _] ->
            NewSeen = dict:remove(H, Seen),
            NewSum = if dict:is_key(H, Seen) -> Sum; true -> Sum - hd(T) end,
            max_sum(K, T, NewSum + H, MaxSum1, NewSeen, K)
    end.
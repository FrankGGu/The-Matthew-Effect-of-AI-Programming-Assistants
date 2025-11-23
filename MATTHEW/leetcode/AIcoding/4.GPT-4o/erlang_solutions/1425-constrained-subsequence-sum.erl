-module(solution).
-export([constrained_subsequence_sum/2]).

constrained_subsequence_sum(A, K) ->
    N = length(A),
    MaxQueue = queue:new(),
    Sums = lists:duplicate(N, 0),
    Sums = lists:map(fun(Index) -> 
        if Index == 0 -> lists:nth(Index + 1, A);
           true -> 
               {ok, {MaxQueue1, Max}} = dequeue_max(MaxQueue),
               if Max > 0 -> Max + lists:nth(Index + 1, A);
                  true -> lists:nth(Index + 1, A)
               end
        end
    end, lists:seq(0, N - 1)),
    lists:max(Sums).

dequeue_max(MaxQueue) ->
    case queue:is_empty(MaxQueue) of
        true -> {ok, {MaxQueue, 0}};
        false -> 
            {Value, MaxQueue1} = queue:out(MaxQueue),
            {ok, {MaxQueue1, Value}}
    end.
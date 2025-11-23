-module(solution).
-export([minimum_sum/2]).

minimum_sum(K, target) ->
    minimum_sum(K, target, 0, 0).

minimum_sum(_, Target, _, Sum) when Sum >= Target ->
    Sum;

minimum_sum(K, Target, Current, Sum) ->
    Next = Current + K,
    if
        (Next rem 10) == K ->
            minimum_sum(K, Target, Next, Sum + Next);
        true ->
            minimum_sum(K, Target, Next, Sum)
    end.
-module(construct_target_array).
-export([is_possible/1]).

is_possible(Target) ->
    N = length(Target),
    if N == 1 ->
        lists:nth(1, Target) == 1;
    true ->
        {Sum, Max} = lists:foldl(
            fun(X, {S, M}) ->
                {S + X, max(M, X)}
            end, {0, 0}, Target),
        is_possible_helper(Sum, Max, sorted_set:from_list(Target), N).

is_possible_helper(1, 1, _, _) ->
    true;
is_possible_helper(Sum, Max, Set, N) ->
    RestSum = Sum - Max,
    if RestSum == 0 ->
        false;
    true ->
        Prev = Max rem RestSum,
        if Prev == 0 ->
            if RestSum == 1 ->
                true;
            true ->
                false
            end;
        true ->
            if Prev == Max ->
                false;
            true ->
                NewSum = Sum - Max + Prev,
                NewSet = sorted_set:del(Max, Set),
                NewSet2 = sorted_set:add(Prev, NewSet),
                is_possible_helper(NewSum, Prev, NewSet2, N)
            end
        end
    end.
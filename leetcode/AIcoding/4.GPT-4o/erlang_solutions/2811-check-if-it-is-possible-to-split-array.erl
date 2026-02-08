-module(solution).
-export([can_split/1]).

can_split(Array) ->
    Sum = lists:sum(Array),
    N = length(Array),
    if 
        Sum rem N =:= 0 ->
            Target = Sum div N,
            can_split_helper(Array, Target, 0, 0);
        true ->
            false
    end.

can_split_helper([], _, CurrentSum, Count) ->
    Count > 0 andalso CurrentSum =:= 0;
can_split_helper([H | T], Target, CurrentSum, Count) ->
    NewSum = CurrentSum + H,
    if 
        NewSum > Target ->
            false;
        NewSum =:= Target ->
            can_split_helper(T, Target, 0, Count + 1);
        true ->
            can_split_helper(T, Target, NewSum, Count)
    end.
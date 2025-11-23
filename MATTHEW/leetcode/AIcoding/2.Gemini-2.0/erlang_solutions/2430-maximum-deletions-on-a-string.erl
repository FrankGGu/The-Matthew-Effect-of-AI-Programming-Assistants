-module(maximum_deletions).
-export([max_deletions/1]).

max_deletions(S) ->
    Len = length(S),
    Memo = dict:new(),
    max_deletions_helper(S, Len, Memo).

max_deletions_helper(_, 0, _) ->
    0;
max_deletions_helper(S, Len, Memo) ->
    case dict:find(Len, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Result = calculate_max_deletions(S, Len, Memo),
            dict:store(Len, Result, Memo),
            Result
    end.

calculate_max_deletions(S, Len, Memo) ->
    MaxDeletions = lists:foldl(
        fun(I, Acc) ->
            Sub1 = lists:sublist(S, 1, I),
            Sub2 = lists:sublist(S, I + 1, I),
            if
                Sub1 == Sub2 ->
                    max(Acc, 1 + max_deletions_helper(lists:sublist(S, I + I + 1, Len - I - I), Len - I - I, Memo));
                true ->
                    Acc
            end
        end,
        1,
        lists:seq(1, Len div 2)
    ),
    MaxDeletions.
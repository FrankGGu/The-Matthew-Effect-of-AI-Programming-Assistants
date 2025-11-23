-module(solution).
-export([max_repeating/2]).

max_repeating(String, Substring) ->
    max_repeating_helper(String, Substring, 0, 1).

max_repeating_helper(String, Substring, MaxCount, CurrentCount) ->
    case string:split(String, Substring) of
        Parts when length(Parts) > 1 ->
            NewCount = CurrentCount + 1,
            max_repeating_helper(string:join(Parts, ""), Substring, max(MaxCount, CurrentCount), NewCount);
        _ ->
            MaxCount
    end.
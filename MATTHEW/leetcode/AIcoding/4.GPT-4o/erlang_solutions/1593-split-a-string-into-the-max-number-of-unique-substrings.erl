-module(solution).
-export([max_unique_split/1]).

max_unique_split(Str) ->
    max_unique_split_helper(Str, [], 0).

max_unique_split_helper([], _, Max) ->
    Max;
max_unique_split_helper(Str, Used, Max) ->
    lists:foldl(fun(S, Acc) ->
        case lists:member(S, Used) of
            true -> Acc;
            false -> 
                NewUsed = [S | Used],
                NewMax = length(NewUsed),
                max_unique_split_helper(tl(Str), NewUsed, max(NewMax, Acc))
        end
    end, Max, split_string(Str)).

split_string(Str) ->
    lists:map(fun(X) -> string:to_list(X) end, string:tokens(Str, "")).
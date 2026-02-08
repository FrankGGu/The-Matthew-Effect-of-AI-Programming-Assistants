-module(longest_substring).
-export([longest_substring/2]).

longest_substring(S, K) ->
    longest_substring_helper(string:to_list(S), K).

longest_substring_helper([], _) ->
    0;
longest_substring_helper(List, K) ->
    Counts = lists:foldl(fun(C, Acc) ->
                                 maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, List),
    LessK = [C || C <- maps:keys(Counts), maps:get(C, Counts) < K],
    if LessK == [] ->
        length(List)
    else
        Split = string:tokens(list_to_binary(List), list_to_binary(LessK)),
        lists:max([longest_substring_helper(binary_to_list(Sub), K) || Sub <- Split])
    end.
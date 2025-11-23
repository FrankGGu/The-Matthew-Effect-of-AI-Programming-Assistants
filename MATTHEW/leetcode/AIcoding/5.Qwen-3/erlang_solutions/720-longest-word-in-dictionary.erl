-module(longest_word_in_dictionary).
-export([find_longest_word/1]).

find_longest_word(Dict) ->
    Sorted = lists:sort(Dict),
    lists:foldl(fun(W, {MaxLen, MaxWord}) ->
        case length(W) of
            L when L > MaxLen -> {L, W};
            _ -> {MaxLen, MaxWord}
        end
    end, {0, ""}, Sorted).
-module(reverse_prefix_of_word).
-export([reverse_prefix/2]).

reverse_prefix(Word, Ch) ->
    case string:find(Word, Ch) of
        {ok, Index} ->
            Prefix = string:substr(Word, 1, Index + 1),
            ReversePrefix = lists:reverse(string:to_list(Prefix)),
            lists:flatten([ReversePrefix ++ string:substr(Word, Index + 2)]);
        error ->
            Word
    end.
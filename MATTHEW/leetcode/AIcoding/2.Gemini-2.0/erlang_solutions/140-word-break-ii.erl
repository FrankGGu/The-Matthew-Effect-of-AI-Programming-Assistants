-module(word_break_ii).
-export([word_break/2]).

word_break(S, WordDict) ->
    word_break_helper(S, sets:from_list(WordDict), []).

word_break_helper("", _, Acc) ->
    [lists:reverse(Acc)];
word_break_helper(S, WordSet, Acc) ->
    Len = length(S),
    word_break_helper(S, WordSet, Acc, 1, Len, []).

word_break_helper(S, WordSet, Acc, Start, Len, Result) when Start > Len ->
    Result;
word_break_helper(S, WordSet, Acc, Start, Len, Result) ->
    Sub = string:sub(S, 1, Start),
    case sets:is_element(Sub, WordSet) of
        true ->
            Remaining = string:sub(S, Start + 1, Len - Start),
            NewResult =
                case Remaining of
                    "" ->
                        [lists:reverse([Sub | Acc]) || true];
                    _ ->
                        lists:flatten([word_break_helper(Remaining, WordSet, [Sub | Acc])])
                end,
            word_break_helper(S, WordSet, Acc, Start + 1, Len, Result ++ NewResult);
        false ->
            word_break_helper(S, WordSet, Acc, Start + 1, Len, Result)
    end.
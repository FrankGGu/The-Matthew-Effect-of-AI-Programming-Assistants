-module(solution).
-export([reversePrefix/2]).

reversePrefix(Word, Ch) ->
    WordList = unicode:characters_to_list(Word),
    case split_at_char(WordList, Ch) of
        {Prefix, Suffix} ->
            unicode:characters_to_binary(lists:reverse(Prefix) ++ Suffix);
        not_found ->
            Word
    end.

split_at_char(List, Ch) ->
    split_at_char(List, Ch, []).

split_at_char([Ch | T], Ch, Acc) ->
    {lists:reverse(Acc) ++ [Ch], T};
split_at_char([H | T], Ch, Acc) ->
    split_at_char(T, Ch, [H | Acc]);
split_at_char([], _Ch, _Acc) ->
    not_found.
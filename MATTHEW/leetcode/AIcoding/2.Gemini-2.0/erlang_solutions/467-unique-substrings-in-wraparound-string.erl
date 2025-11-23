-module(unique_substrings).
-export([find_substring_in_wrapround_string/1]).

find_substring_in_wrapround_string(P) ->
    find_substring_in_wrapround_string(P, 0).

find_substring_in_wrapround_string(P, Acc) ->
    Len = length(P),
    find_substring_in_wrapround_string(P, Len, 0, lists:seq($a, $z), [], Acc).

find_substring_in_wrapround_string(_, 0, _, _, MaxLen, Acc) ->
    lists:sum(MaxLen) + Acc;
find_substring_in_wrapround_string(P, Len, I, Alphabet, MaxLen, Acc) ->
    Char = lists:nth(I + 1, string:to_charlist(P)),
    find_substring_in_wrapround_string(P, Len, I, Alphabet, MaxLen, Char, 1, Acc).

find_substring_in_wrapround_string(P, Len, I, Alphabet, MaxLen, Char, CurrLen, Acc) ->
    if
        I + CurrLen >= Len ->
            NewMaxLen = update_max_len(Char, CurrLen, Alphabet, MaxLen),
            find_substring_in_wrapround_string(P, Len - (I + 1), 0, Alphabet, NewMaxLen, Acc);
        true ->
            NextChar = lists:nth(I + CurrLen + 1, string:to_charlist(P)),
            if
                is_consecutive(Char, NextChar, Alphabet) ->
                    find_substring_in_wrapround_string(P, Len, I, Alphabet, MaxLen, NextChar, CurrLen + 1, Acc);
                true ->
                    NewMaxLen = update_max_len(Char, CurrLen, Alphabet, MaxLen),
                    find_substring_in_wrapround_string(P, Len, I + CurrLen, Alphabet, NewMaxLen, Acc)
            end
    end.

is_consecutive(Char1, Char2, Alphabet) ->
    Index1 = lists:index(Char1, Alphabet),
    Index2 = lists:index(Char2, Alphabet),
    (Index2 - Index1) rem 26 == 1.

update_max_len(Char, CurrLen, Alphabet, MaxLen) ->
    Index = lists:index(Char, Alphabet),
    case lists:nth(Index, MaxLen) < CurrLen of
        true ->
            lists:nthreplace(Index, MaxLen, CurrLen);
        false ->
            MaxLen
    end.
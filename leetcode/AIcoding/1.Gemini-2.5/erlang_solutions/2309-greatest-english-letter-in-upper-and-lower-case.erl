-module(solution).
-export([greatest_letter/1]).

-spec greatest_letter(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
greatest_letter(S_binary) ->
    S_chars = unicode:characters_to_list(S_binary),
    find_greatest_letter(S_chars, $Z).

find_greatest_letter(S_chars, Char) when Char >= $A ->
    LowerChar = Char + 32,
    case {lists:member(Char, S_chars), lists:member(LowerChar, S_chars)} of
        {true, true} ->
            unicode:characters_to_binary([Char]);
        _ ->
            find_greatest_letter(S_chars, Char - 1)
    end;
find_greatest_letter(_S_chars, _Char) ->
    <<"">>.
-module(solution).
-export([modify_string/1]).

modify_string(S) ->
    List = string:to_list(S),
    NewList = replace_questions(List, 0, []),
    string:list_to_string(NewList).

replace_questions([], _, Acc) -> lists:reverse(Acc);
replace_questions([? | Rest], Prev, Acc) ->
    Char = choose_char(Prev, Acc),
    replace_questions(Rest, Char, [Char | Acc]);
replace_questions([H | Rest], Prev, Acc) ->
    replace_questions(Rest, H, [H | Acc]).

choose_char(Prev, Acc) ->
    choose_char_helper(Prev, Acc, $a).

choose_char_helper(Prev, Acc, Char) when Char > $z -> $a;
choose_char_helper(Prev, Acc, Char) ->
    case lists:member(Char, Acc) orelse Char =:= Prev of
        true -> choose_char_helper(Prev, Acc, Char + 1);
        false -> Char
    end.
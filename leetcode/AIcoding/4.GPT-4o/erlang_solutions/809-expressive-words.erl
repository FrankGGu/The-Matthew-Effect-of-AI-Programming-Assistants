-module(solution).
-export([expressive_words/2]).

expressive_words(phrase, words) ->
    PhraseChars = string:to_list(phrase),
    PhraseGroups = group_chars(PhraseChars, []),
    lists:filter(fun(W) -> is_expressive(PhraseGroups, string:to_list(W)) end, words).

group_chars([], Acc) -> lists:reverse(Acc);
group_chars([H | T], Acc) ->
    {Group, Rest} = lists:splitwith(fun(X) -> X =:= H end, [H | T]),
    group_chars(Rest, [{H, length(Group)} | Acc]).

is_expressive([], []) -> true;
is_expressive([{C, L} | PhraseRemainder], [C | WordRemainder]) ->
    case is_expressive(PhraseRemainder, WordRemainder) of
        true -> 
            case L >= 3 of
                true -> true;
                false -> length(WordRemainder) =:= L
            end;
        false -> false
    end;
is_expressive(_, _) -> false.
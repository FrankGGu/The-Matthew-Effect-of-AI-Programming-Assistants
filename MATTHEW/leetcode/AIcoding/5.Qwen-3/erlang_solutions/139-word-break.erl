-module(word_break).
-export([wordBreak/2]).

wordBreak(_, []) -> true;
wordBreak(Word, Dict) ->
    wordBreak(Word, Dict, 0, dict:from_list(Dict), dict:size(Dict)).

wordBreak(_, _, _, _, 0) -> false;
wordBreak(Word, Dict, Pos, D, MaxLen) ->
    case Pos of
        Len when Len == length(Word) -> true;
        _ ->
            Words = dict:to_list(D),
            lists:any(fun({W, _}) ->
                             LenW = length(W),
                             if
                                 Pos + LenW > length(Word) -> false;
                                 true ->
                                     Sub = string:substr(Word, Pos + 1, LenW),
                                     Sub == W andalso wordBreak(Word, Dict, Pos + LenW, D, MaxLen)
                             end
                     end, Words).
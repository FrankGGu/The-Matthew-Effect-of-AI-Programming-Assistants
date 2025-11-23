-module(solution).
-export([findSubstring/2]).

findSubstring(St, Words) ->
    case Words of
        [] -> [];
        _ ->
            WordLen = length(hd(Words)),
            TotalWords = length(Words),
            TotalLen = WordLen * TotalWords,
            StrLen = length(St),
            if
                TotalLen > StrLen -> [];
                true ->
                    Results = lists:seq(0, StrLen - TotalLen),
                    lists:foldl(fun(I, Acc) ->
                                        findFromIndex(St, I, Words, WordLen, TotalWords, TotalLen, [])
                                    end, [], Results)
            end
    end.

findFromIndex(_, _, _, _, 0, _, Acc) ->
    Acc;
findFromIndex(St, Start, Words, WordLen, Remaining, TotalLen, Acc) ->
    End = Start + WordLen,
    if
        End > length(St) -> Acc;
        true ->
            Word = string:substr(St, Start + 1, WordLen),
            case lists:member(Word, Words) of
                true ->
                    NewWords = lists:delete(Word, Words),
                    NewRemaining = Remaining - 1,
                    NewStart = Start + WordLen,
                    findFromIndex(St, NewStart, NewWords, WordLen, NewRemaining, TotalLen, [Start | Acc]);
                false ->
                    Acc
            end
    end.
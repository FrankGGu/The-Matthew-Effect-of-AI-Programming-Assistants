-module(longestWord).
-export([findLongestWord/2]).

findLongestWord(S, Dictionary) ->
    findLongestWord(S, Dictionary, "").

findLongestWord(_S, [], Acc) ->
    Acc;
findLongestWord(S, [Word | Rest], Acc) ->
    case isSubsequence(Word, S) of
        true ->
            case string:len(Word) > string:len(Acc) orelse (string:len(Word) == string:len(Acc) and Word < Acc) of
                true ->
                    findLongestWord(S, Rest, Word);
                false ->
                    findLongestWord(S, Rest, Acc)
            end;
        false ->
            findLongestWord(S, Rest, Acc)
    end.

isSubsequence(Sub, Str) ->
    isSubsequence(Sub, Str, 0, 0).

isSubsequence([], _Str, _SubIndex, _StrIndex) ->
    true;
isSubsequence(_Sub, [], _SubIndex, _StrIndex) ->
    false;
isSubsequence(Sub, Str, SubIndex, StrIndex) ->
    SubChar = string:substr(Sub, SubIndex + 1, 1),
    StrChar = string:substr(Str, StrIndex + 1, 1),
    case SubChar == StrChar of
        true ->
            case SubIndex + 1 == string:len(Sub) of
                true ->
                    true;
                false ->
                    isSubsequence(Sub, Str, SubIndex + 1, StrIndex + 1)
            end;
        false ->
            case StrIndex + 1 == string:len(Str) of
                true ->
                    false;
                false ->
                    isSubsequence(Sub, Str, SubIndex, StrIndex + 1)
            end
    end.
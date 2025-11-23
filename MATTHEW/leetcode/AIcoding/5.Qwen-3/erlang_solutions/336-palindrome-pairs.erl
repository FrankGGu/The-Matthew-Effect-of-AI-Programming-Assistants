-module(palindrome_pairs).
-export([palindrome_pairs/1]).

palindrome_pairs(Words) ->
    WordsList = lists:reverse(Words),
    Length = length(Words),
    Results = [],
    FindPairs(0, Words, WordsList, Length, Results).

FindPairs(_, _, _, 0, Acc) ->
    Acc;
FindPairs(I, Words, WordsList, N, Acc) ->
    Word = lists:nth(I + 1, Words),
    ReverseWord = lists:reverse(Word),
    FindPairsInner(0, Words, WordsList, I, Word, ReverseWord, N, Acc).

FindPairsInner(J, Words, WordsList, I, Word, ReverseWord, N, Acc) ->
    if
        J >= N ->
            FindPairs(I + 1, Words, WordsList, N - 1, Acc);
        true ->
            JWord = lists:nth(J + 1, Words),
            case J of
                I -> FindPairsInner(J + 1, Words, WordsList, I, Word, ReverseWord, N, Acc);
                _ ->
                    case is_palindrome(Word ++ JWord) of
                        true -> 
                            NewAcc = [[I, J] | Acc],
                            FindPairsInner(J + 1, Words, WordsList, I, Word, ReverseWord, N, NewAcc);
                        false ->
                            case is_palindrome(JWord ++ Word) of
                                true -> 
                                    NewAcc = [[J, I] | Acc],
                                    FindPairsInner(J + 1, Words, WordsList, I, Word, ReverseWord, N, NewAcc);
                                false -> 
                                    FindPairsInner(J + 1, Words, WordsList, I, Word, ReverseWord, N, Acc)
                            end
                    end
            end
    end.

is_palindrome(S) ->
    S == lists:reverse(S).
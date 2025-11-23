-module(concatenated_words).
-export([findAllConcatenatedWords/1]).

findAllConcatenatedWords(Words) ->
    Sorted = lists:sort(fun(A, B) -> length(A) < length(B) end, Words),
    WordSet = sets:from_list(Sorted),
    lists:filter(fun(W) -> is_concatenated(W, WordSet, 0) end, Sorted).

is_concatenated(_, _, _) when length([]) > 1000 -> false;
is_concatenated(Word, WordSet, Index) ->
    case Index of
        Len when Len >= length(Word) -> true;
        _ ->
            lists:any(fun(End) ->
                              Sub = string:substr(Word, Index + 1, End - Index),
                              case sets:is_element(Sub, WordSet) of
                                  true ->
                                      is_concatenated(Word, WordSet, End);
                                  false ->
                                      false
                              end
                      end, lists:seq(Index + 1, min(length(Word), Index + 20))).

is_concatenated(Word, WordSet, Index, Acc) ->
    case Index of
        Len when Len >= length(Word) -> Acc > 0;
        _ ->
            lists:any(fun(End) ->
                              Sub = string:substr(Word, Index + 1, End - Index),
                              case sets:is_element(Sub, WordSet) of
                                  true ->
                                      is_concatenated(Word, WordSet, End, Acc + 1);
                                  false ->
                                      false
                              end
                      end, lists:seq(Index + 1, min(length(Word), Index + 20))).
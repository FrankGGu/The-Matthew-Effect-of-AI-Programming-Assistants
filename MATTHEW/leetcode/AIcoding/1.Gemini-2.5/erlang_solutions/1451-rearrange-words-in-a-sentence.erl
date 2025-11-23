-module(solution).
-export([arrangeWords/1]).

arrangeWords(Text) ->
    Words = string:tokens(Text, " "),

    IndexedWords = lists:zip(lists:seq(0, length(Words) - 1), Words),

    WordTuples = lists:map(fun({Idx, Word}) ->
                                LowerWord = string:to_lower(Word),
                                {string:len(LowerWord), Idx, LowerWord}
                            end, IndexedWords),

    SortedWordTuples = lists:sort(fun({L1, I1, _}, {L2, I2, _}) ->
                                      if L1 =:= L2 -> I1 < I2;
                                         true -> L1 < L2
                                      end
                                  end, WordTuples),

    SortedWords = lists:map(fun({_, _, Word}) -> Word end, SortedWordTuples),

    case SortedWords of
        [] ->
            "";
        [FirstWord | RestWords] ->
            CapitalizedFirstWord = capitalize_first_letter(FirstWord),
            string:join([CapitalizedFirstWord | RestWords], " ")
    end.

capitalize_first_letter(Word) ->
    case string:len(Word) of
        0 ->
            "";
        _ ->
            FirstChar = string:slice(Word, 0, 1),
            Rest = string:slice(Word, 1),
            string:to_upper(FirstChar) ++ Rest
    end.
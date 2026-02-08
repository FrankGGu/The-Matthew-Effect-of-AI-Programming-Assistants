-module(solution).
-export([minimum_booths/1]).

get_word_freq(Word) ->
    lists:foldl(fun(Char, AccMap) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, AccMap)
    end, #{}, Word).

minimum_booths(Words) ->
    GlobalMaxFreq = lists:foldl(fun(Word, AccGlobalMaxFreq) ->
        WordFreq = get_word_freq(Word),
        maps:fold(fun(Char, Count, CurrentGlobalMaxFreq) ->
            maps:update_with(Char, fun(V) -> max(V, Count) end, Count, CurrentGlobalMaxFreq)
        end, AccGlobalMaxFreq, WordFreq)
    end, #{}, Words),

    ResultChars = lists:flatmap(fun({Char, Count}) ->
        lists:duplicate(Count, Char)
    end, maps:to_list(GlobalMaxFreq)),

    ResultChars.
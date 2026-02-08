-module(solution).
-export([find_all_concatenated_words_in_a_dict/1]).

find_all_concatenated_words_in_a_dict(Words) ->
    Dict = sets:from_list(Words),
    lists:filter(fun(Word) -> is_concatenated(Word, Dict) end, Words).

is_concatenated(Word, Dict) ->
    is_concatenated_helper(Word, Dict, 0, 0, length(Word)).

is_concatenated_helper(Word, Dict, Start, Count, Len) ->
    if
        Start >= Len andalso Count >= 2 -> true;
        Start >= Len -> false;
        true ->
            lists:any(fun(End) ->
                          SubWord = string:substr(Word, Start + 1, End - Start),
                          (sets:is_element(SubWord, Dict) andalso
                           (Count > 0 orelse End =/= Len)) andalso
                          is_concatenated_helper(Word, Dict, End, Count + 1, Len)
                       end, lists:seq(Start + 1, Len))
    end.
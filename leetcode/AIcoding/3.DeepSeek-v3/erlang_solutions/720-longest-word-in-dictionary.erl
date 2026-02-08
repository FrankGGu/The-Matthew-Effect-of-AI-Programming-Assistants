-module(solution).
-export([longest_word/1]).

longest_word(Words) ->
    Sorted = lists:sort(Words),
    PrefixSet = sets:new(),
    Longest = "",
    lists:foldl(fun(Word, {Set, CurrLongest}) ->
        case (length(Word) =:= 1) orelse sets:is_element(string:substr(Word, 1, length(Word) - 1, Set) of
            true ->
                NewSet = sets:add_element(Word, Set),
                NewLongest = case (length(Word) > length(CurrLongest)) orelse 
                                  (length(Word) =:= length(CurrLongest) andalso Word < CurrLongest of
                                 true -> Word;
                                 false -> CurrLongest
                             end,
                {NewSet, NewLongest};
            false ->
                {Set, CurrLongest}
        end
    end, {PrefixSet, Longest}, Sorted),
    {_, Result} = lists:foldl(fun(Word, {Set, CurrLongest}) ->
        case (length(Word) =:= 1) orelse sets:is_element(string:substr(Word, 1, length(Word) - 1, Set) of
            true ->
                NewSet = sets:add_element(Word, Set),
                NewLongest = case (length(Word) > length(CurrLongest)) orelse 
                                  (length(Word) =:= length(CurrLongest) andalso Word < CurrLongest of
                                 true -> Word;
                                 false -> CurrLongest
                             end,
                {NewSet, NewLongest};
            false ->
                {Set, CurrLongest}
        end
    end, {PrefixSet, Longest}, Sorted),
    Result.
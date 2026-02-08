-module(magic_dictionary).
-export([MagicDictionary/0, build/1, search/2]).

-record(dict, {words}).

MagicDictionary() ->
    Dict = #dict{words = []},
    {ok, Dict}.

build(Dict, Words) ->
    NewDict = Dict#dict{words = Words},
    {ok, NewDict}.

search(Dict, SearchWord) ->
    lists:any(fun(Word) -> one_edit_away(Word, SearchWord) end, Dict#dict.words).

one_edit_away(Word, SearchWord) ->
    case length(Word) - length(SearchWord) of
        0 -> count_diffs(Word, SearchWord) == 1;
        1 -> count_diffs(SearchWord, Word) == 1;
        _ -> false
    end.

count_diffs(W1, W2) ->
    lists:foldl(fun({C1, C2}, Acc) -> 
        if 
            C1 =/= C2 -> Acc + 1;
            true -> Acc
        end 
    end, 0, lists:zip(W1, W2)).
-module(solution).
-export([new/0, buildDict/2, search/2]).

new() ->
    gb_sets:new().

buildDict(_This, WordList) ->
    lists:foldl(fun(Word, Dict) -> gb_sets:add(Word, Dict) end, gb_sets:new(), WordList).

search(Dict, SearchWord) ->
    SearchWordLen = length(SearchWord),
    gb_sets:fold(fun(DictWord, Acc) ->
        if Acc == true ->
            true;
        else
            if length(DictWord) == SearchWordLen ->
                differs_by_one(DictWord, SearchWord)
            else
                false
            end
        end
    end, false, Dict).

differs_by_one(Word1, Word2) ->
    differs_by_one_helper(Word1, Word2, 0).

differs_by_one_helper([], [], 1) ->
    true;
differs_by_one_helper([], [], _) ->
    false;
differs_by_one_helper([H1|T1], [H2|T2], DiffCount) ->
    NewDiffCount = if H1 == H2 -> DiffCount; else DiffCount + 1 end,
    if NewDiffCount > 1 ->
        false;
    else
        differs_by_one_helper(T1, T2, NewDiffCount)
    end.
-module(solution).
-export([are_sentences_similar/1]).

are_sentences_similar(Strings) ->
    Count = lists:foldl(fun(Str, Acc) ->
        lists:foldl(fun(Char, Acc2) ->
            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc2)
        end, Acc, Str)
    end, maps:new(), Strings),
    lists:all(fun({_, V}) -> V rem length(Strings) == 0 end, maps:to_list(Count)).
-module(magic_dict).
-export([build_dict/1, search/2]).

build_dict(Words) ->
    Dict = lists:foldl(fun(W, Acc) -> dict:store(W, true, Acc) end, dict:new(), Words),
    {Dict, length(lists:usort(Words))}.

search({Dict, _}, Word) ->
    lists:any(fun(Word2) -> is_one_diff(Word, Word2) end, dict:keys(Dict)).

is_one_diff(A, B) ->
    A =/= B andalso length(lists:filter(fun(C) -> C /= D end, lists:zip(A, B))) == 1.
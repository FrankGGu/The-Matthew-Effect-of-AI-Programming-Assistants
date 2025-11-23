-module(magic_dictionary).
-export([new/0, build_dict/1, search/2]).

-record(dictionary, {words = []}).

new() ->
    #dictionary{}.

build_dict(Dict, Words) ->
    Dict#dictionary{words = Words}.

search(Dict, SearchWord) ->
    lists:any(fun(Word) -> is_one_edit_away(Word, SearchWord) end, Dict#dictionary.words).

is_one_edit_away(W1, W2) ->
    case string:len(W1) - string:len(W2) of
        0 -> one_replace(W1, W2);
        1 -> one_insert(W2, W1);
        -1 -> one_insert(W1, W2);
        _ -> false
    end.

one_replace(W1, W2) ->
    lists:sum(lists:zip(string:to_list(W1), string:to_list(W2)), fun({C1, C2}) -> if C1 =/= C2 -> 1; true -> 0 end end) =:= 1.

one_insert(Short, Long) ->
    lists:foldl(fun(C, Acc) -> if C /= hd(Long) -> Acc + 1; true -> Acc end end, 0, string:to_list(Short)) =:= 1.
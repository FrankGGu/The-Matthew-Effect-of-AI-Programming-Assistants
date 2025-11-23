-module(magic_dictionary).
-export([build_dict/1, search/2]).

build_dict(Words) ->
    Words.

search(Dict, Word) ->
    lists:any(fun(W) -> is_one_edit(W, Word) end, Dict).

is_one_edit(A, B) ->
    case length(A) == length(B) of
        true ->
            lists:foldl(fun({C1, C2}, Acc) -> 
                            if C1 /= C2 andalso Acc == 0 -> 1;
                               C1 /= C2 andalso Acc == 1 -> 2;
                               true -> Acc
                            end
                        end, 0, lists:zip(A, B)) == 1;
        false ->
            false
    end.
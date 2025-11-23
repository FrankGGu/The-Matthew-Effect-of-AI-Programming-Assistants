-module(solution).
-export([string_matching/1]).

string_matching(Words) ->
    Result = lists:foldl(fun(Word1, Acc) ->
                             IsSub = lists:any(fun(Word2) ->
                                                   Word1 /= Word2 andalso string:str(Word2, Word1) > 0
                                               end, Words),

                             if IsSub andalso not lists:member(Word1, Acc) ->
                                    [Word1 | Acc];
                                else ->
                                    Acc
                             end
                         end, [], Words),

    lists:reverse(Result).
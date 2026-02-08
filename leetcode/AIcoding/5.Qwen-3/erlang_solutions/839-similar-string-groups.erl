-module(similar_string_groups).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
    Groups = lists:foldl(fun(Str, Acc) -> add_to_group(Str, Acc) end, dict:new(), Strs),
    dict:size(Groups).

add_to_group(Str, Dict) ->
    case find_group(Str, Dict) of
        none ->
            dict:store(Str, [Str], Dict);
        Group ->
            dict:store(Group, [Str | dict:fetch(Group, Dict)], Dict)
    end.

find_group(Str, Dict) ->
    lists:foldl(fun(Key, Acc) ->
                    if Acc /= none -> Acc;
                       true -> check_similarity(Str, Key) andalso Key
                    end
                end, none, dict:keys(Dict)).

check_similarity(A, B) ->
    Count = lists:foldl(fun({C, D}, Acc) -> 
                            if C /= D -> Acc + 1;
                               true -> Acc
                            end
                        end, 0, lists:zip(A, B)),
    Count =< 2.
-module(solution).
-export([evaluate/2]).

evaluate(S, Knowledge) ->
    KnowledgeMap = lists:foldl(fun([K, V], Acc) -> maps:put(list_to_binary(K), list_to_binary(V), Acc) end, #{}, Knowledge),
    evaluate_string(S, KnowledgeMap).

evaluate_string(S, KnowledgeMap) ->
    evaluate_string_recursive(S, KnowledgeMap, []).

evaluate_string_recursive([], _KnowledgeMap, Acc) ->
    lists:reverse(Acc);
evaluate_string_recursive([$( | T], KnowledgeMap, Acc) ->
    {KeyChars, Rest} = get_key_chars(T, []),
    KeyBin = list_to_binary(lists:reverse(KeyChars)),
    ValueBin = maps:get(KeyBin, KnowledgeMap, <<"?">>),
    evaluate_string_recursive(Rest, KnowledgeMap, lists:reverse(binary_to_list(ValueBin), Acc));
evaluate_string_recursive([H | T], KnowledgeMap, Acc) ->
    evaluate_string_recursive(T, KnowledgeMap, [H | Acc]).

get_key_chars([$) | T], Acc) ->
    {Acc, T};
get_key_chars([H | T], Acc) ->
    get_key_chars(T, [H | Acc]).
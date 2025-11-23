-module(solution).
-export([evaluate/2]).

evaluate(S, Knowledge) ->
    KnowledgeMap = maps:from_list(Knowledge),
    evaluate(S, KnowledgeMap, [], []).

evaluate([], _, Current, Result) ->
    lists:reverse([lists:reverse(Current) | Result]);
evaluate([$( | Rest], KnowledgeMap, Current, Result) ->
    {Key, Remaining} = extract_key(Rest, []),
    Value = maps:get(Key, KnowledgeMap, "?"),
    evaluate(Remaining, KnowledgeMap, [], [Value | [lists:reverse(Current) | Result]]);
evaluate([Char | Rest], KnowledgeMap, Current, Result) ->
    evaluate(Rest, KnowledgeMap, [Char | Current], Result).

extract_key([$) | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
extract_key([Char | Rest], Acc) ->
    extract_key(Rest, [Char | Acc]).
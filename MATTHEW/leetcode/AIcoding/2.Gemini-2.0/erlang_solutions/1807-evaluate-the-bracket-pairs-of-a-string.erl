-module(evaluate_bracket_pairs).
-export([evaluate/2]).

evaluate(S, Knowledge) ->
    evaluate(S, Knowledge, []).

evaluate([], _Knowledge, Acc) ->
    lists:reverse(Acc);
evaluate([$[ | Rest], Knowledge, Acc) ->
    evaluate_key(Rest, Knowledge, [], Acc);
evaluate([C | Rest], Knowledge, Acc) ->
    evaluate(Rest, Knowledge, [C | Acc]).

evaluate_key([], _Knowledge, _KeyAcc, Acc) ->
    evaluate([], _Knowledge, [$[ | lists:reverse(_KeyAcc) ++ Acc]);
evaluate_key([$] | Rest], Knowledge, KeyAcc, Acc) ->
    Key = lists:reverse(KeyAcc),
    Value = maps:get(list_to_binary(Key), Knowledge, <<"?"">>),
    evaluate(Rest, Knowledge, binary_to_list(Value) ++ Acc);
evaluate_key([C | Rest], Knowledge, KeyAcc, Acc) ->
    evaluate_key(Rest, Knowledge, [C | KeyAcc], Acc).
-module(evaluate_bracket_pairs).
-export([evaluate/1]).

evaluate(S) ->
    evaluate(S, [], []).

evaluate([], _, Stack) ->
    lists:reverse(Stack);
evaluate([$( | T], Acc, Stack) ->
    evaluate(T, [], [lists:reverse(Acc) | Stack]);
evaluate([$] | T], Acc, [H | TStack]) ->
    evaluate(T, [H | Acc], TStack);
evaluate([C | T], Acc, Stack) ->
    evaluate(T, [C | Acc], Stack).
-module(reformat_phone_number).
-export([reformatNumber/1]).

reformatNumber(S) ->
    Nums = [C || C <- S, C >= '0', C =< '9'],
    reformat(Nums, []).

reformat([], Acc) ->
    lists:reverse(Acc);
reformat([A, B, C | Rest], Acc) ->
    reformat(Rest, [A, B, C | Acc]);
reformat([A, B | []], Acc) ->
    lists:reverse([A, B | Acc]);
reformat([A | []], Acc) ->
    lists:reverse([A | Acc]);
reformat(Nums, Acc) ->
    [A, B, C | Rest] = Nums,
    reformat(Rest, [A, B, C | Acc]).

reformat(Nums, Acc) when length(Nums) > 0 ->
    {Chunk, Rest} = lists:split(3, Nums),
    reformat(Rest, [Chunk | Acc]);
reformat([], Acc) ->
    lists:reverse(Acc).

reformat(Nums, Acc) ->
    reformat_aux(Nums, Acc, []).

reformat_aux([], Acc, Result) ->
    lists:reverse(lists:join("-", lists:map(fun lists:flatten/1), lists:reverse(Result)));
reformat_aux([A,B,C | Rest], Acc, Result) ->
    reformat_aux(Rest, Acc, [[A,B,C] | Result]);
reformat_aux([A,B | []], Acc, Result) ->
    reformat_aux([], Acc, [[A,B] | Result]);
reformat_aux([A | []], Acc, Result) ->
    reformat_aux([], Acc, [[A] | Result]).
-module(combination_sum).
-export([combination_sum/2]).

combination_sum(Candidates, Target) ->
    combination_sum_helper(Candidates, Target, [], []).

combination_sum_helper([], 0, Acc, Result) ->
    [lists:reverse(Acc) | Result];
combination_sum_helper([], Target, _, Result) when Target < 0 ->
    Result;
combination_sum_helper([], Target, _, Result) ->
    Result;
combination_sum_helper([H|T], 0, Acc, Result) ->
    [lists:reverse(Acc) | Result];
combination_sum_helper([H|T], Target, Acc, Result) when Target < 0 ->
    Result;
combination_sum_helper([H|T], Target, Acc, Result) ->
    Result1 = combination_sum_helper([H|T], Target - H, [H|Acc], Result),
    Result2 = combination_sum_helper(T, Target, Acc, Result1),
    Result2.
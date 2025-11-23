-module(combinationsum).
-export([combination_sum/2]).

combination_sum(Numbers, Target) ->
    lists:usort(combination_sum(Numbers, Target, [])).

combination_sum(_, 0, Current) ->
    [lists:reverse(Current)];
combination_sum([], _, _) ->
    [];
combination_sum([Num | Rest], Target, Current) when Num > Target ->
    combination_sum(Rest, Target, Current);
combination_sum([Num | Rest], Target, Current) ->
    case Num =< Target of
        true ->
            lists:append(
                combination_sum(Rest, Target, Current),
                combination_sum([Num | Rest], Target - Num, [Num | Current])
            );
        false ->
            combination_sum(Rest, Target, Current)
    end.
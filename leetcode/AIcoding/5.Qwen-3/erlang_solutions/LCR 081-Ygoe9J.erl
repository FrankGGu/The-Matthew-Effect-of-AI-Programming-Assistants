-module(combinationsum).
-export([combination_sum/2]).

combination_sum(Numbers, Target) ->
    combination_sum(Numbers, Target, []).

combination_sum(_, 0, Acc) ->
    [lists:reverse(Acc)];
combination_sum([], _, _) ->
    [];
combination_sum([Num | Rest], Target, Acc) ->
    if
        Num > Target ->
            combination_sum(Rest, Target, Acc);
        true ->
            case combination_sum(Rest, Target - Num, [Num | Acc]) of
                [] ->
                    combination_sum(Rest, Target, Acc);
                Results ->
                    Results ++ combination_sum(Rest, Target, Acc)
            end
    end.
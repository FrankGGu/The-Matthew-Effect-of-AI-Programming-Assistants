-module(solution).
-export([combinationSum4/2]).

combinationSum4(Target, Numbers) ->
    Count = lists:duplicate(Target + 1, 0),
    Count = count_combinations(Target, Numbers, Count),
    lists:nth(Target + 1, Count).

count_combinations(0, _Numbers, Count) ->
    lists:replace_at(Count, 1, 1);
count_combinations(Target, Numbers, Count) when Target > 0 ->
    Count = lists:foldl(fun(Number, Acc) ->
        if Target - Number >= 0 ->
            lists:replace_at(Acc, Target + 1, lists:nth(Target + 1, Acc) + lists:nth(Target - Number + 1, Acc));
        true -> Acc
        end
    end, Count, Numbers),
    count_combinations(Target - 1, Numbers, Count).
-module(solution).
-export([word_count/2]).

word_count(StartWords, TargetWords) ->
    StartSets = sets:from_list([lists:sort(W) || W <- StartWords]),
    TargetSets = [lists:sort(W) || W <- TargetWords],
    lists:foldl(fun(Target, Acc) ->
        case lists:any(fun(I) ->
            Sub = lists:sublist(Target, 1, I-1) ++ lists:sublist(Target, I+1, length(Target)),
            sets:is_element(Sub, StartSets)
        end, lists:seq(1, length(Target))) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, TargetSets).
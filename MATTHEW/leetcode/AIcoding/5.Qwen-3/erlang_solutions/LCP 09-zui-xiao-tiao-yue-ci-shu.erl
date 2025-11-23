-module(jump_game).
-export([jump/1]).

jump(Numbers) ->
    jump(Numbers, 0, 0, erlang:length(Numbers) - 1).

jump(_, Current, Steps, Target) when Current >= Target ->
    Steps;
jump(Numbers, Current, Steps, Target) ->
    MaxReach = Current + lists:nth(Current + 1, Numbers),
    Next = lists:foldl(fun(I, Acc) -> if I > Acc -> I; true -> Acc end end, Current, lists:seq(Current + 1, min(MaxReach, Target))),
    jump(Numbers, Next, Steps + 1, Target).
-module(min_rounds).
-export([minimumRounds/1]).

minimumRounds(Tasks) ->
    Count = maps:from_list([{Task, 0} || Task <- Tasks]),
    CountMap = lists:foldl(fun(Task, Acc) -> maps:update(Task, maps:get(Task, Acc) + 1, Acc) end, Count, Tasks),
    Rounds = lists:foldl(fun({_Task, C}, Acc) ->
        if
            C == 1 -> error;
            true -> Acc + ceil(C / 3)
        end
    end, 0, maps:to_list(CountMap)),
    Rounds.

ceil(X) when X =< 0 -> 0;
ceil(X) -> trunc(X + 0.999999).
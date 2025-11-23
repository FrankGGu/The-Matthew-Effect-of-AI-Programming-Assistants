-module(solution).
-export([is_possible/1]).

is_possible(Target) ->
    Total = lists:sum(Target),
    Max = lists:max(Target),
    MaxIndex = lists:position(Max, Target),
    NewMax = Total - Max,
    if
        NewMax < Max -> false;
        true -> is_possible(lists:replace_at(Target, MaxIndex, NewMax))
    end.
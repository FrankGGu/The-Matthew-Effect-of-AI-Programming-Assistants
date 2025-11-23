-module(solution).
-export([max_blessing/1]).

max_blessing(Blessings) ->
    max_blessing(Blessings, 0, 0).

max_blessing([], Max, _) ->
    Max;
max_blessing([H | T], Max, Count) ->
    case H of
        1 ->
            NewCount = Count + 1,
            NewMax = max(Max, NewCount),
            max_blessing(T, NewMax, NewCount);
        _ ->
            max_blessing(T, Max, 0)
    end.
-module(solution).
-export([minDifficulty/2]).

minDifficulty(JobDifficulty, D) ->
    N = length(JobDifficulty),
    if
        D > N -> -1;
        D == N -> lists:max(JobDifficulty);
        true -> min_difficulty(JobDifficulty, D, N, 0, 0, 0, #{} )
    end.

min_difficulty(_, 0, _, Min, _, _, _) -> Min;
min_difficulty(Difficulty, D, N, Min, DayMax, DayJobs, Vis) ->
    if
        DayJobs == 0 -> 
            min_difficulty(Difficulty, D-1, N, Min + DayMax, 0, 0, Vis);
        true ->
            Min1 = lists:foldl(fun(X, Acc) -> 
                NewDayMax = max(DayMax, X),
                NewDayJobs = DayJobs + 1,
                NewVis = maps:put(DayJobs, DayMax, Vis),
                if
                    NewDayJobs > D -> Acc;
                    true -> 
                        min_difficulty(Difficulty, D, N, Acc, NewDayMax, NewDayJobs, NewVis)
                end
            end, Min, lists:sublist(Difficulty, DayJobs))
    end.
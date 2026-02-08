-module(solution).
-export([memLeak/2]).

memLeak(Memory1, Memory2) ->
    solve(1, Memory1, Memory2).

solve(Time, Mem1, Mem2) ->
    if
        Mem1 < Time andalso Mem2 < Time ->
            [Time, Mem1, Mem2];
        Mem1 >= Mem2 ->
            if
                Mem1 >= Time ->
                    solve(Time + 1, Mem1 - Time, Mem2);
                true ->
                    solve(Time + 1, Mem1, Mem2 - Time)
            end;
        true ->
            if
                Mem2 >= Time ->
                    solve(Time + 1, Mem1, Mem2 - Time);
                true ->
                    solve(Time + 1, Mem1 - Time, Mem2)
            end
    end.
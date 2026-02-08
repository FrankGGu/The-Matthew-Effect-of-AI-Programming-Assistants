-module(solution).
-export([find_right_interval/1]).

find_right_interval(Intervals) ->
    N = length(Intervals),
    if 
        N == 0 -> [];
        true ->
            Indexed = lists:zip(lists:seq(0, N-1), Intervals),
            Sorted = lists:sort(fun({I1, [S1, _E1]}, {I2, [S2, _E2]}) -> 
                if S1 == S2 -> I1 < I2; true -> S1 < S2 end 
            end, Indexed),
            Indices = [I || {I, _} <- Sorted],
            Starts = [S || {_, [S, _E]} <- Sorted],
            lists:map(fun([_S, E]) -> 
                case find_first_ge(Starts, E) of
                    -1 -> -1;
                    Pos -> lists:nth(Pos+1, Indices)
                end
            end, Intervals)
    end.

find_first_ge(List, Target) ->
    find_first_ge(List, Target, 0, length(List)-1).

find_first_ge(List, Target, Low, High) ->
    if 
        Low > High -> -1;
        true ->
            Mid = (Low + High) div 2,
            {Left, [MidVal | _Right]} = lists:split(Mid, List),
            if
                MidVal >= Target ->
                    if 
                        Mid == 0 -> Mid;
                        true ->
                            {_, [Prev | _]} = lists:split(Mid-1, List),
                            if 
                                Prev >= Target -> find_first_ge(List, Target, Low, Mid-1);
                                true -> Mid
                            end
                    end;
                true -> find_first_ge(List, Target, Mid+1, High)
            end
    end.
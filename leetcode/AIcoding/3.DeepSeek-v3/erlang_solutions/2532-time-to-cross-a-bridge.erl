-module(solution).
-export([find_crossing_time/4]).

find_crossing_time(N, K, Time, Eff) ->
    LeftWait = lists:sort(fun(A, B) -> 
        {TA, WA, IA} = A,
        {TB, WB, IB} = B,
        if
            WA =/= WB -> WA > WB;
            true -> IA > IB
        end
    end, [{lists:nth(I, Time), lists:nth(I, Eff), I - 1} || I <- lists:seq(1, K)]),
    RightWait = [],
    LeftAvail = [],
    RightAvail = [],
    {TimeTaken, _, _, _, _} = simulate(N, LeftWait, RightWait, LeftAvail, RightAvail, 0),
    TimeTaken.

simulate(0, _, _, _, _, Time) -> {Time, [], [], [], []};
simulate(N, LeftWait, RightWait, LeftAvail, RightAvail, Time) ->
    {NewTime, NewLeftWait, NewRightWait, NewLeftAvail, NewRightAvail} = 
        case {LeftWait, RightWait} of
            {[], []} when LeftAvail =:= [], RightAvail =:= [] -> {Time, [], [], [], []};
            _ ->
                case RightWait of
                    [] ->
                        [Worker | RestLeft] = LeftWait,
                        {T, W, I} = Worker,
                        NewTime1 = Time + T,
                        NewLeftAvail1 = lists:sort(fun(A, B) -> 
                            {TA, IA} = A,
                            {TB, IB} = B,
                            if
                                TA =/= TB -> TA < TB;
                                true -> IA < IB
                            end
                        end, [{lists:nth(I + 1, Eff), I} || {_, _, I} <- LeftAvail] ++ [{W, I}]),
                        simulate(N, RestLeft, RightWait, NewLeftAvail1, RightAvail, NewTime1);
                    _ ->
                        [Worker | RestRight] = RightWait,
                        {T, W, I} = Worker,
                        NewTime1 = Time + T,
                        NewRightAvail1 = lists:sort(fun(A, B) -> 
                            {TA, IA} = A,
                            {TB, IB} = B,
                            if
                                TA =/= TB -> TA < TB;
                                true -> IA < IB
                            end
                        end, [{lists:nth(I + 1, Eff), I} || {_, _, I} <- RightAvail] ++ [{W, I}]),
                        simulate(N - 1, LeftWait, RestRight, LeftAvail, NewRightAvail1, NewTime1)
                end
        end,
    simulate(N, NewLeftWait, NewRightWait, NewLeftAvail, NewRightAvail, NewTime).
-module(solution).
-export([find_judge/2]).

find_judge(N, Trust) ->
    OutDegrees = maps:new(),
    InDegrees = maps:new(),

    {FinalOutDegrees, FinalInDegrees} = lists:foldl(
        fun([A, B], {AccOut, AccIn}) ->
            NewAccOut = maps:update_with(A, fun(V) -> V + 1 end, 1, AccOut),
            NewAccIn = maps:update_with(B, fun(V) -> V + 1 end, 1, AccIn),
            {NewAccOut, NewAccIn}
        end,
        {OutDegrees, InDegrees},
        Trust
    ),

    find_judge_loop(1, N, FinalOutDegrees, FinalInDegrees).

find_judge_loop(CurrentPerson, N, OutDegrees, InDegrees) when CurrentPerson =< N ->
    Out = maps:get(CurrentPerson, OutDegrees, 0),
    In = maps:get(CurrentPerson, InDegrees, 0),

    if
        Out == 0 andalso In == N - 1 ->
            CurrentPerson;
        true ->
            find_judge_loop(CurrentPerson + 1, N, OutDegrees, InDegrees)
    end;
find_judge_loop(_CurrentPerson, _N, _OutDegrees, _InDegrees) ->
    -1.
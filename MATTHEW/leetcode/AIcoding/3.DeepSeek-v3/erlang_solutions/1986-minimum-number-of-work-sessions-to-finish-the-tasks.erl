-module(solution).
-export([min_sessions/2]).

min_sessions(Tasks, SessionTime) ->
    N = length(Tasks),
    DP = maps:new(),
    DP1 = maps:put(0, {0, SessionTime}, DP),
    solve(Tasks, N, 0, DP1, SessionTime).

solve(Tasks, N, Mask, DP, SessionTime) ->
    case Mask =:= (1 bsl N) - 1 of
        true -> 
            {Ans, _} = maps:get(Mask, DP),
            Ans;
        false ->
            case maps:is_key(Mask, DP) of
                true -> 
                    {Ans, _} = maps:get(Mask, DP),
                    Ans;
                false ->
                    DP1 = maps:put(Mask, {infinity, 0}, DP),
                    {NewDP, MinSessions} = try_tasks(Tasks, N, Mask, 0, DP1, SessionTime),
                    {Ans, _} = maps:get(Mask, NewDP),
                    Ans
            end
    end.

try_tasks(Tasks, N, Mask, I, DP, SessionTime) when I < N ->
    case (Mask band (1 bsl I)) =:= 0 of
        true ->
            Task = lists:nth(I + 1, Tasks),
            {PrevSessions, PrevRemain} = maps:get(Mask, DP),
            NewMask = Mask bor (1 bsl I),
            case PrevRemain >= Task of
                true ->
                    NewRemain = PrevRemain - Task,
                    case maps:is_key(NewMask, DP) of
                        true ->
                            {ExistingSessions, ExistingRemain} = maps:get(NewMask, DP),
                            case (ExistingSessions > PrevSessions) or 
                                 ((ExistingSessions =:= PrevSessions) and (ExistingRemain < NewRemain)) of
                                true ->
                                    NewDP = maps:put(NewMask, {PrevSessions, NewRemain}, DP),
                                    try_tasks(Tasks, N, Mask, I + 1, NewDP, SessionTime);
                                false ->
                                    try_tasks(Tasks, N, Mask, I + 1, DP, SessionTime)
                            end;
                        false ->
                            NewDP = maps:put(NewMask, {PrevSessions, NewRemain}, DP),
                            try_tasks(Tasks, N, Mask, I + 1, NewDP, SessionTime)
                    end;
                false ->
                    NewSessions = PrevSessions + 1,
                    NewRemain = SessionTime - Task,
                    case maps:is_key(NewMask, DP) of
                        true ->
                            {ExistingSessions, ExistingRemain} = maps:get(NewMask, DP),
                            case (ExistingSessions > NewSessions) or 
                                 ((ExistingSessions =:= NewSessions) and (ExistingRemain < NewRemain)) of
                                true ->
                                    NewDP = maps:put(NewMask, {NewSessions, NewRemain}, DP),
                                    try_tasks(Tasks, N, Mask, I + 1, NewDP, SessionTime);
                                false ->
                                    try_tasks(Tasks, N, Mask, I + 1, DP, SessionTime)
                            end;
                        false ->
                            NewDP = maps:put(NewMask, {NewSessions, NewRemain}, DP),
                            try_tasks(Tasks, N, Mask, I + 1, NewDP, SessionTime)
                    end
            end;
        false ->
            try_tasks(Tasks, N, Mask, I + 1, DP, SessionTime)
    end;
try_tasks(_, _, _, _, DP, _) ->
    {DP, maps:get(Mask, DP)}.
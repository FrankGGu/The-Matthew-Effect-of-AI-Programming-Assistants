-module(solution).
-export([construct_largest_sequence/1]).

construct_largest_sequence(N) ->
    L = 2 * N - 1,
    InitialTuple = list_to_tuple(lists:duplicate(L, 0)),
    InitialUsedMask = 0,
    ResultTuple = backtrack(0, InitialTuple, InitialUsedMask, N, L),
    tuple_to_list(ResultTuple).

backtrack(Idx, CurrentTuple, _CurrentUsedMask, _N, L) when Idx == L ->
    CurrentTuple;
backtrack(Idx, CurrentTuple, CurrentUsedMask, N, L) ->
    case element(Idx + 1, CurrentTuple) of
        0 ->
            try_placing(N, Idx, CurrentTuple, CurrentUsedMask, N, L);
        _ ->
            backtrack(Idx + 1, CurrentTuple, CurrentUsedMask, N, L)
    end.

try_placing(0, _Idx, _CurrentTuple, _CurrentUsedMask, _N, _L) ->
    false;
try_placing(Val, Idx, CurrentTuple, CurrentUsedMask, N, L) ->
    Bit = (1 bsl Val),
    case (CurrentUsedMask band Bit) of
        0 ->
            case Val of
                1 ->
                    NewTuple = setelement(Idx + 1, CurrentTuple, 1),
                    NewUsedMask = CurrentUsedMask bor Bit,
                    Result = backtrack(Idx + 1, NewTuple, NewUsedMask, N, L),
                    case Result of
                        false ->
                            try_placing(Val - 1, Idx, CurrentTuple, CurrentUsedMask, N, L);
                        _ ->
                            Result
                    end;
                _ when Val > 1 ->
                    TargetIdx = Idx + Val,
                    if
                        TargetIdx < L andalso element(TargetIdx + 1, CurrentTuple) == 0 ->
                            NewTuple1 = setelement(Idx + 1, CurrentTuple, Val),
                            NewTuple2 = setelement(TargetIdx + 1, NewTuple1, Val),
                            NewUsedMask = CurrentUsedMask bor Bit,
                            Result = backtrack(Idx + 1, NewTuple2, NewUsedMask, N, L),
                            case Result of
                                false ->
                                    try_placing(Val - 1, Idx, CurrentTuple, CurrentUsedMask, N, L);
                                _ ->
                                    Result
                            end;
                        true ->
                            try_placing(Val - 1, Idx, CurrentTuple, CurrentUsedMask, N, L)
                    end
            end;
        _ ->
            try_placing(Val - 1, Idx, CurrentTuple, CurrentUsedMask, N, L)
    end.
-module(solution).
-export([get_max_grid_happiness/5]).

get_max_grid_happiness(M, N, Introverts, Extroverts, _Grid) ->
    Pow3List = [erlang:trunc(math:pow(3, I)) || I <- lists:seq(0, N - 1)],
    MaxMask = erlang:trunc(math:pow(3, N)) - 1,
    Memo = maps:new(),
    {Result, _FinalMemo} = solve_memo(0, 0, Introverts, Extroverts, M, N, MaxMask, Pow3List, Memo),
    Result.

solve_memo(Row, PrevMask, IntrovertsLeft, ExtrovertsLeft, M, N, MaxMask, Pow3List, Memo) ->
    State = {Row, PrevMask, IntrovertsLeft, ExtrovertsLeft},
    case maps:find(State, Memo) of
        {ok, Result} -> {Result, Memo};
        error ->
            {Result, NewMemo} =
                if
                    Row == M -> {0, Memo};
                    true ->
                        calculate_max_happiness_for_row_and_update_memo(Row, PrevMask, IntrovertsLeft, ExtrovertsLeft, M, N, MaxMask, Pow3List, Memo)
                end,
            {Result, maps:put(State, Result, NewMemo)}
    end.

calculate_max_happiness_for_row_and_update_memo(Row, PrevMask, IntrovertsLeft, ExtrovertsLeft, M, N, MaxMask, Pow3List, Memo) ->
    InitialMaxHappiness = 0,
    InitialMemo = Memo,
    {FinalMaxHappiness, FinalMemo} =
        lists:foldl(
            fun(CurrentRowMask, {AccMaxHappiness, AccMemo}) ->
                {HappinessFromRow, UsedIntroverts, UsedExtroverts} = calculate_happiness_for_row(CurrentRowMask, PrevMask, N, Pow3List),
                if
                    IntrovertsLeft >= UsedIntroverts andalso ExtrovertsLeft >= UsedExtroverts ->
                        {RemainingHappiness, UpdatedMemo} = solve_memo(Row + 1, CurrentRowMask, IntrovertsLeft - UsedIntroverts, ExtrovertsLeft - UsedExtroverts, M, N, MaxMask, Pow3List, AccMemo),
                        {max(AccMaxHappiness, HappinessFromRow + RemainingHappiness), UpdatedMemo};
                    true ->
                        {AccMaxHappiness, AccMemo}
                end
            end,
            {InitialMaxHappiness, InitialMemo},
            lists:seq(0, MaxMask)
        ),
    {FinalMaxHappiness, FinalMemo}.

calculate_happiness_for_row(CurrentRowMask, PrevMask, N, Pow3List) ->
    calculate_happiness_for_row_acc(CurrentRowMask, PrevMask, N - 1, Pow3List, 0, 0, 0).

calculate_happiness_for_row_acc(_CurrentRowMask, _PrevMask, -1, _Pow3List, AccHappiness, AccIntroverts, AccExtroverts) ->
    {AccHappiness, AccIntroverts, AccExtroverts};
calculate_happiness_for_row_acc(CurrentRowMask, PrevMask, C, Pow3List, AccHappiness, AccIntroverts, AccExtroverts) ->
    Pow3C = lists:nth(C + 1, Pow3List),
    CurrentCellState = (CurrentRowMask div Pow3C) rem 3,
    PrevCellState = (PrevMask div Pow3C) rem 3,

    {CellHappiness, CellUsedIntroverts, CellUsedExtroverts} =
        case CurrentCellState of
            1 ->
                H = 120,
                UI = 1,
                UE = 0,
                {H1, UI1, UE1} =
                    if C > 0 ->
                        Pow3Cminus1 = lists:nth(C, Pow3List),
                        LeftCellState = (CurrentRowMask div Pow3Cminus1) rem 3,
                        case LeftCellState of
                            1 -> {H - 60, UI, UE};
                            2 -> {H - 10, UI, UE};
                            _ -> {H, UI, UE}
                        end;
                    true -> {H, UI, UE}
                    end,
                {H2, UI2, UE2} =
                    case PrevCellState of
                        1 -> {H1 - 60, UI1, UE1};
                        2 -> {H1 - 10, UI1, UE1};
                        _ -> {H1, UI1, UE1}
                    end,
                {H2, UI2, UE2};
            2 ->
                H = 40,
                UI = 0,
                UE = 1,
                {H1, UI1, UE1} =
                    if C > 0 ->
                        Pow3Cminus1 = lists:nth(C, Pow3List),
                        LeftCellState = (CurrentRowMask div Pow3Cminus1) rem 3,
                        case LeftCellState of
                            1 -> {H - 10, UI, UE};
                            2 -> {H + 40, UI, UE};
                            _ -> {H, UI, UE}
                        end;
                    true -> {H, UI, UE}
                    end,
                {H2, UI2, UE2} =
                    case PrevCellState of
                        1 -> {H1 - 10, UI1, UE1};
                        2 -> {H1 + 40, UI1, UE1};
                        _ -> {H1, UI1, UE1}
                    end,
                {H2, UI2, UE2};
            _ ->
                {0, 0, 0}
        end,
    calculate_happiness_for_row_acc(CurrentRowMask, PrevMask, C - 1, Pow3List, AccHappiness + CellHappiness, AccIntroverts + CellUsedIntroverts, AccExtroverts + CellUsedExtroverts).
-module(solution).
-export([checkIfGridCanBeCutIntoSections/1]).

-define(MEMO_TABLE, solution_memo).

checkIfGridCanBeCutIntoSections(ListGrid) ->
    Grid = list_to_tuple(lists:map(fun list_to_tuple/1, ListGrid)),

    try ets:delete(?MEMO_TABLE) of
        _ -> ok
    catch
        error:badarg -> ok
    end,
    ets:new(?MEMO_TABLE, [set, public, {read_concurrency, true}, {write_concurrency, true}]),

    M = tuple_size(Grid),
    N = tuple_size(element(1, Grid)),
    Result = solve(Grid, 0, 0, M - 1, N - 1),

    ets:delete(?MEMO_TABLE),
    Result.

solve(Grid, R1, C1, R2, C2) ->
    Key = {R1, C1, R2, C2},
    case ets:lookup(?MEMO_TABLE, Key) of
        [{Key, Result}] ->
            Result;
        [] ->
            Result = calculate_solve(Grid, R1, C1, R2, C2),
            ets:insert(?MEMO_TABLE, {Key, Result}),
            Result
    end.

calculate_solve(Grid, R1, C1, R2, C2) ->
    if is_monochromatic(Grid, R1, C1, R2, C2) ->
        true;
    true ->
        CanCutHorizontally = 
            lists:any(fun(R_cut) ->
                solve(Grid, R1, C1, R_cut, C2) andalso solve(Grid, R_cut + 1, C1, R2, C2)
            end, lists:seq(R1, R2 - 1)),

        CanCutVertically = 
            lists:any(fun(C_cut) ->
                solve(Grid, R1, C1, R2, C_cut) andalso solve(Grid, R1, C_cut + 1, R2, C2)
            end, lists:seq(C1, C2 - 1)),

        CanCutHorizontally orelse CanCutVertically
    end.

is_monochromatic(Grid, R1, C1, R2, C2) ->
    Val = element(C1 + 1, element(R1 + 1, Grid)),
    check_rows_mono(Grid, R1, C1, R2, C2, Val).

check_rows_mono(_Grid, R, _C1, R2, _C2, _Val) when R > R2 -> true;
check_rows_mono(Grid, R, C1, R2, C2, Val) ->
    Row = element(R + 1, Grid),
    case check_cols_mono(Row, C1, C2, Val) of
        true -> check_rows_mono(Grid, R + 1, C1, R2, C2, Val);
        false -> false
    end.

check_cols_mono(_Row, C, C2, _Val) when C > C2 -> true;
check_cols_mono(Row, C, C2, Val) ->
    case element(C + 1, Row) of
        Val -> check_cols_mono(Row, C + 1, C2, Val);
        _ -> false
    end.
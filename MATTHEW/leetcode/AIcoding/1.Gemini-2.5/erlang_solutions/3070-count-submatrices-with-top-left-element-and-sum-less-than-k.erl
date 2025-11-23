-module(solution).
-export([countSubmatrices/2]).

countSubmatrices(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),

    PS_matrix = build_ps_matrix(Grid, M, N),

    count_less_than_k(PS_matrix, K, 0).

build_ps_matrix(Grid, _M, _N) ->
    build_ps_rows(Grid, []).

build_ps_rows([], AccPSRows) ->
    lists:reverse(AccPSRows);
build_ps_rows([GridRow | RestGridRows], AccPSRows) ->
    PrevPSRow = 
        case AccPSRows of
            [] -> [];
            _ -> hd(AccPSRows)
        end,

    CurrentPSRow = build_ps_row(GridRow, PrevPSRow),
    build_ps_rows(RestGridRows, [CurrentPSRow | AccPSRows]).

build_ps_row(GridRow, PrevPSRow) ->
    PaddedPrevPSRow = [0 | PrevPSRow],
    build_ps_row_helper(GridRow, PrevPSRow, PaddedPrevPSRow, [], 0).

build_ps_row_helper([], [], [], AccCurrentPSRow, _PrevPSValInCurrentRow) ->
    lists:reverse(AccCurrentPSRow);
build_ps_row_helper([GridVal | GridRowTail], [], [ValAboveLeft | PaddedPrevPSRowTail], AccCurrentPSRow, PrevPSValInCurrentRow) ->
    ValAbove = 0,
    CurrentVal = GridVal + ValAbove + PrevPSValInCurrentRow - ValAboveLeft,
    build_ps_row_helper(GridRowTail, [], PaddedPrevPSRowTail, [CurrentVal | AccCurrentPSRow], CurrentVal);
build_ps_row_helper([GridVal | GridRowTail], [ValAbove | PrevPSRowTail], [ValAboveLeft | PaddedPrevPSRowTail], AccCurrentPSRow, PrevPSValInCurrentRow) ->
    CurrentVal = GridVal + ValAbove + PrevPSValInCurrentRow - ValAboveLeft,
    build_ps_row_helper(GridRowTail, PrevPSRowTail, PaddedPrevPSRowTail, [CurrentVal | AccCurrentPSRow], CurrentVal).

count_less_than_k(PS_matrix, K, InitialCount) ->
    lists:foldl(fun(Row, AccCount) ->
                    lists:foldl(fun(Val, InnerAccCount) ->
                                    case Val =< K of
                                        true -> InnerAccCount + 1;
                                        false -> InnerAccCount
                                    end
                                end, AccCount, Row)
                end, InitialCount, PS_matrix).
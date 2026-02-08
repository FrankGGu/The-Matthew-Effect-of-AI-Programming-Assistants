-module(cat_and_mouse_ii).
-export([canMouseWin/4]).

-define(MOUSE_WIN, 1).
-define(CAT_WIN, -1).
-define(DRAW, 0).
-define(UNKNOWN, 2). % Special value for 'currently computing'

-define(CACHE, cat_mouse_cache).

canMouseWin(Grid, CatJump, MouseJump) ->
    R = length(Grid),
    C = length(hd(Grid)),

    {MouseStart, CatStart} = find_initial_positions(Grid, R, C),

    catch ets:delete(?CACHE),
    ets:new(?CACHE, [set, public]),

    dp(MouseStart, CatStart, mouse_turn, R, C, CatJump, MouseJump, Grid).

dp({MR, MC}, {CR, CC}, PlayerTurn, R, C, CatJump, MouseJump, Grid) ->
    if MR == CR, MC == CC -> ?CAT_WIN; true -> ok end,

    if get_cell(Grid, MR, MC) == $F -> ?MOUSE_WIN; true -> ok end,

    if get_cell(Grid, CR, CC) == $F -> ?CAT_WIN; true -> ok end,

    Key = {{MR, MC}, {CR, CC}, PlayerTurn},

    case ets:lookup(?CACHE, Key) of
        [{Key, ?UNKNOWN}] ->
            ?DRAW;
        [{Key, Result}] ->
            Result;
        [] ->
            ets:insert(?CACHE, {Key, ?UNKNOWN}),

            Result = case PlayerTurn of
                mouse_turn ->
                    handle_mouse_turn({MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid);
                cat_turn ->
                    handle_cat_turn({MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid)
            end,
            ets:insert(?CACHE, {Key, Result}),
            Result
    end.

handle_mouse_turn({MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) ->
    PossibleMoves = get_possible_moves(MR, MC, MouseJump, R, C, Grid, cat_pos, {CR, CC}),
    handle_mouse_turn_recursive(PossibleMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid).

handle_mouse_turn_recursive(PossibleMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) ->
    case PossibleMoves of
        [] -> ?CAT_WIN;
        [{NMR, NMC} | RestMoves] ->
            NextResult = dp({NMR, NMC}, {CR, CC}, cat_turn, R, C, CatJump, MouseJump, Grid),
            if NextResult == ?MOUSE_WIN ->
                ?MOUSE_WIN;
            NextResult == ?DRAW ->
                case handle_mouse_turn_recursive(RestMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) of
                    ?CAT_WIN -> ?DRAW;
                    OtherResult -> OtherResult
                end;
            true ->
                handle_mouse_turn_recursive(RestMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid)
            end
    end.

handle_cat_turn({MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) ->
    PossibleMoves = get_possible_moves(CR, CC, CatJump, R, C, Grid, mouse_pos, {MR, MC}),
    handle_cat_turn_recursive(PossibleMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid).

handle_cat_turn_recursive(PossibleMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) ->
    case PossibleMoves of
        [] -> ?MOUSE_WIN;
        [{NCR, NCC} | RestMoves] ->
            NextResult = dp({MR, MC}, {NCR, NCC}, mouse_turn, R, C, CatJump, MouseJump, Grid),
            if NextResult == ?CAT_WIN ->
                ?CAT_WIN;
            NextResult == ?DRAW ->
                case handle_cat_turn_recursive(RestMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid) of
                    ?MOUSE_WIN -> ?DRAW;
                    OtherResult -> OtherResult
                end;
            true ->
                handle_cat_turn_recursive(RestMoves, {MR, MC}, {CR, CC}, R, C, CatJump, MouseJump, Grid)
            end
    end.

get_possible_moves(CurrentR, CurrentC, MaxJump, R, C, Grid, OpponentType, {OpponentR, OpponentC}) ->
    Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

    lists:flatmap(
        fun({Dr, Dc}) ->
            collect_moves_in_direction(CurrentR, CurrentC, Dr, Dc, MaxJump, 1, R, C, Grid, OpponentType, {OpponentR, OpponentC}, [])
        end,
        Dirs
    ).

collect_moves_in_direction(CurrentR, CurrentC, Dr, Dc, MaxJump, Step, R, C, Grid, OpponentType, {OpponentR, OpponentC}, Acc) when Step =< MaxJump ->
    Nr = CurrentR + Dr * Step,
    Nc = CurrentC + Dc * Step,

    if Nr >= 0, Nr < R, Nc >= 0, Nc < C, get_cell(Grid, Nr, Nc) /= $# ->
        if OpponentType == cat_pos, Nr == OpponentR, Nc == OpponentC ->
            Acc;
        OpponentType == mouse_pos, Nr == OpponentR, Nc == OpponentC ->
            Acc;
        true ->
            collect_moves_in_direction(CurrentR, CurrentC, Dr, Dc, MaxJump, Step + 1, R, C, Grid, OpponentType, {OpponentR, OpponentC}, [{Nr, Nc} | Acc])
        end
    else
        Acc
    end;
collect_moves_in_direction(_CurrentR, _CurrentC, _Dr, _Dc, _MaxJump, _Step, _R, _C, _Grid, _OpponentType, _OpponentPos, Acc) ->
    Acc.

get_cell(Grid, R_idx, C_idx) ->
    lists:nth(C_idx + 1, lists:nth(R_idx + 1, Grid)).

find_initial_positions(Grid, R, C) ->
    MouseStart = {0,0},
    CatStart = {0,0},

    {FinalMouseStart, FinalCatStart} = 
        lists:foldl(
            fun(RowIdx, {AccMouse, AccCat}) ->
                Row = lists:nth(RowIdx + 1, Grid),
                lists:foldl(
                    fun(ColIdx, {InnerAccMouse, InnerAccCat}) ->
                        Cell = lists:nth(ColIdx + 1, Row),
                        case Cell of
                            $M -> {{RowIdx, ColIdx}, InnerAccCat};
                            $C -> {InnerAccMouse, {RowIdx, ColIdx}};
                            _  -> {InnerAccMouse, InnerAccCat}
                        end
                    end,
                    {AccMouse, AccCat},
                    lists:seq(0, C - 1)
                )
            end,
            {MouseStart, CatStart},
            lists:seq(0, R - 1)
        ),
    {FinalMouseStart, FinalCatStart}.
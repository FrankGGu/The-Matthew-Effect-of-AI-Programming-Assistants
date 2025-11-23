-module(solution).
-export([catAndMouse/1]).

catAndMouse(Graph) ->
    N = length(Graph),
    InitialDp = maps:new(),
    {Result, _FinalDp} = dfs(1, 2, 0, N, Graph, InitialDp),
    case Result of
        1 -> 1; % Mouse wins
        2 -> 2; % Cat wins
        3 -> 0  % Draw
    end.

dfs(M, C, T, N, Graph, Dp) ->
    % Base cases
    if
        M == 0 -> {1, Dp}; % Mouse at hole 0 wins
        M == C -> {2, Dp}  % Cat catches mouse, Cat wins
    else
        Key = {M, C, T},
        case maps:find(Key, Dp) of
            {ok, Res} -> {Res, Dp}; % State already computed
            error ->
                % Mark as visiting (-1) to detect cycles
                Dp1 = maps:put(Key, -1, Dp),
                {Result, Dp2} = evaluate_state(M, C, T, N, Graph, Dp1),
                FinalDp = maps:put(Key, Result, Dp2),
                {Result, FinalDp}
        end
    end.

evaluate_state(M, C, T, N, Graph, Dp) ->
    if
        T == 0 -> % Mouse's turn
            MouseMoves = lists:nth(M + 1, Graph),
            determine_mouse_outcome(MouseMoves, M, C, N, Graph, Dp, false, false);
        true -> % Cat's turn (T == 1)
            CatMoves = lists:nth(C + 1, Graph),
            ValidCatMoves = lists:filter(fun(Move) -> Move /= 0 end, CatMoves), % Cat cannot move to hole 0
            determine_cat_outcome(ValidCatMoves, M, C, N, Graph, Dp, false, false)
    end.

determine_mouse_outcome([NextM | Rest], M, C, N, Graph, Dp, AccWin, AccDraw) ->
    if AccWin ->
        {1, Dp}; % Mouse already found a winning move, no need to check further
    true ->
        {Res, NewDp} = dfs(NextM, C, 1, N, Graph, Dp),
        EffectiveRes = if Res == -1 -> 3; else -> Res end, % Cycle detected -> Draw
        NewAccWin = AccWin orelse (EffectiveRes == 1),
        NewAccDraw = AccDraw orelse (EffectiveRes == 3),
        determine_mouse_outcome(Rest, M, C, N, Graph, NewDp, NewAccWin, NewAccDraw)
    end;
determine_mouse_outcome([], _M, _C, _N, _Graph, Dp, AccWin, AccDraw) ->
    if
        AccWin -> {1, Dp};
        AccDraw -> {3, Dp};
        true -> {2, Dp} % Mouse cannot win or draw, Cat wins
    end.

determine_cat_outcome([NextC | Rest], M, C, N, Graph, Dp, AccWin, AccDraw) ->
    if AccWin ->
        {2, Dp}; % Cat already found a winning move, no need to check further
    true ->
        {Res, NewDp} = dfs(M, NextC, 0, N, Graph, Dp),
        EffectiveRes = if Res == -1 -> 3; else -> Res end, % Cycle detected -> Draw
        NewAccWin = AccWin orelse (EffectiveRes == 2),
        NewAccDraw = AccDraw orelse (EffectiveRes == 3),
        determine_cat_outcome(Rest, M, C, N, Graph, NewDp, NewAccWin, NewAccDraw)
    end;
determine_cat_outcome([], _M, _C, _N, _Graph, Dp, AccWin, AccDraw) ->
    if
        AccWin -> {2, Dp};
        AccDraw -> {3, Dp};
        true -> {1, Dp} % Cat cannot win or draw, Mouse wins
    end.
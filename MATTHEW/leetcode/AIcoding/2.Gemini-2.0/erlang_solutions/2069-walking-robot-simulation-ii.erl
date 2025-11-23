-module(walking_robot_simulation_ii).
-export([start/4, step/1, getPos/0, getDir/0]).

-record(state, {width, height, x, y, dir}).

start(Width, Height, X, Y) ->
    State = #state{width = Width, height = Height, x = X, y = Y, dir = "East"},
    ets:new(robot, [private, named_table, set]),
    ets:insert(robot, {state, State}),
    ok.

step(Num) ->
    State = ets:lookup_element(robot, state, 2),
    NewState = move(State, Num),
    ets:insert(robot, {state, NewState}),
    ok.

getPos() ->
    State = ets:lookup_element(robot, state, 2),
    {State#state.x, State#state.y}.

getDir() ->
    State = ets:lookup_element(robot, state, 2),
    State#state.dir.

move(State, Num) ->
    W = State#state.width,
    H = State#state.height,
    X = State#state.x,
    Y = State#state.y,
    Dir = State#state.dir,

    Perimeter = 2 * (W + H - 2),

    RealNum = Num rem Perimeter,
    move_helper(State, RealNum, W, H, X, Y, Dir).

move_helper(State, 0, _W, _H, _X, _Y, _Dir) ->
    State;
move_helper(State, N, W, H, X, Y, "East") ->
    DX = min(N, W - 1 - X),
    NewX = X + DX,
    NewN = N - DX,
    if
        NewX == W - 1 andalso NewN > 0 ->
            move_helper(State#state{x = NewX, dir = "North"}, NewN, W, H, NewX, Y, "North");
        true ->
            State#state{x = NewX}
    end;
move_helper(State, N, W, H, X, Y, "North") ->
    DY = min(N, H - 1 - Y),
    NewY = Y + DY,
    NewN = N - DY,
    if
        NewY == H - 1 andalso NewN > 0 ->
            move_helper(State#state{y = NewY, dir = "West"}, NewN, W, H, X, NewY, "West");
        true ->
            State#state{y = NewY}
    end;
move_helper(State, N, W, H, X, Y, "West") ->
    DX = min(N, X),
    NewX = X - DX,
    NewN = N - DX,
    if
        NewX == 0 andalso NewN > 0 ->
            move_helper(State#state{x = NewX, dir = "South"}, NewN, W, H, NewX, Y, "South");
        true ->
            State#state{x = NewX}
    end;
move_helper(State, N, W, H, X, Y, "South") ->
    DY = min(N, Y),
    NewY = Y - DY,
    NewN = N - DY,
    if
        NewY == 0 andalso NewN > 0 ->
            move_helper(State#state{y = NewY, dir = "East"}, NewN, W, H, X, NewY, "East");
        true ->
            State#state{y = NewY}
    end.
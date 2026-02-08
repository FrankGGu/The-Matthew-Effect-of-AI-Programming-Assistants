-module(solution).
-export([min_pushes/1]).

-define(DIRS, [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]).

min_pushes(Grid) ->
    % Parse grid to find initial positions and dimensions
    {StartPlayerPos, StartBoxPos, TargetPos, R, C} = parse_grid(Grid),

    % State for BFS: {BoxPos, PlayerPos, Pushes}
    % Queue: {BoxPos, PlayerPos, Pushes}
    % Visited: set of {BoxPos, PlayerPos}
    Q = queue:new(),
    Visited = sets:new(),

    % Initial state
    InitialState = {StartBoxPos, StartPlayerPos, 0},
    Q1 = queue:in(InitialState, Q),
    Visited1 = sets:add({StartBoxPos, StartPlayerPos}, Visited),

    bfs(Q1, Visited1, Grid, R, C, TargetPos).

bfs(Q, Visited, Grid, MaxR, MaxC, TargetPos) ->
    case queue:out(Q) of
        {{value, {BoxPos, PlayerPos, Pushes}}, Q_rest} ->
            % Check if target is reached
            if BoxPos == TargetPos ->
                Pushes;
            true ->
                % Find all reachable player positions that are adjacent to BoxPos
                % This is an inner BFS for player movement
                ReachablePushingPositions = find_reachable_pushing_positions(BoxPos, PlayerPos, Grid, MaxR, MaxC),

                % Explore pushing moves
                {UpdatedQ, UpdatedVisited} = lists:foldl(fun(PushingPlayerPos, {CurrentQ, CurrentVisited}) ->
                    {Bx, By} = BoxPos,
                    {Px_push, Py_push} = PushingPlayerPos,

                    % Determine push direction
                    % Player at Px_push, Py_push wants to move to BoxPos (Bx, By)
                    % Box moves in direction (Bx - Px_push, By - Py_push)
                    DeltaR = Bx - Px_push,
                    DeltaC = By - Py_push,

                    NewBoxPos = {Bx + DeltaR, By + DeltaC},

                    % Check if NewBoxPos is valid (within bounds, not a wall)
                    % Player ends up at the old BoxPos
                    if is_valid_box_move(Grid, NewBoxPos, MaxR, MaxC) ->
                        NextState = {NewBoxPos, BoxPos}, % Player ends up where box was
                        if not sets:is_element(NextState, CurrentVisited) ->
                            NewVisited_ = sets:add(NextState, CurrentVisited),
                            NewQ_ = queue:in({NewBoxPos, BoxPos, Pushes + 1}, CurrentQ),
                            {NewQ_, NewVisited_};
                        true ->
                            {CurrentQ, CurrentVisited}
                        end;
                    true ->
                        {CurrentQ, CurrentVisited}
                    end
                end, {Q_rest, Visited}, ReachablePushingPositions),

                bfs(UpdatedQ, UpdatedVisited, Grid, MaxR, MaxC, TargetPos)
            end;
        {empty, _} ->
            -1 % Target not reachable
    end.

parse_grid(Grid) ->
    MaxR = length(Grid),
    MaxC = length(hd(Grid)),

    {SP, SB, T} = find_chars(Grid, MaxR, MaxC, {nil, nil, nil}, 0, 0),
    {SP, SB, T, MaxR, MaxC}.

find_chars(Grid, MaxR, MaxC, {SP, SB, T}, Row, Col) ->
    if Row >= MaxR ->
        {SP, SB, T};
    Col >= MaxC ->
        find_chars(Grid, MaxR, MaxC, {SP, SB, T}, Row + 1, 0);
    true ->
        Char = get_char(Grid, {Row, Col}),
        NewSP = if Char == $S -> {Row, Col}; true -> SP end,
        NewSB = if Char == $B -> {Row, Col}; true -> SB end,
        NewT = if Char == $T -> {Row, Col}; true -> T end,
        find_chars(Grid, MaxR, MaxC, {NewSP, NewSB, NewT}, Row, Col + 1)
    end.

get_char(Grid, {Row, Col}) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Grid)).

is_valid_pos({R_pos, C_pos}, MaxR, MaxC) ->
    R_pos >= 0 andalso R_pos < MaxR andalso C_pos >= 0 andalso C_pos < MaxC.

is_wall(Grid, {R_pos, C_pos}) ->
    get_char(Grid, {R_pos, C_pos}) == $#.

is_valid_box_move(Grid, {R_pos, C_pos}, MaxR, MaxC) ->
    is_valid_pos({R_pos, C_pos}, MaxR, MaxC) andalso not is_wall(Grid, {R_pos, C_pos}).

is_valid_player_move(Grid, {R_pos, C_pos}, MaxR, MaxC, BoxPos) ->
    is_valid_pos({R_pos, C_pos}, MaxR, MaxC) andalso not is_wall(Grid, {R_pos, C_pos}) andalso {R_pos, C_pos} /= BoxPos.

is_adjacent({R1, C1}, {R2, C2}) ->
    abs(R1 - R2) + abs(C1 - C2) == 1.

find_reachable_pushing_positions(BoxPos, StartPlayerPos, Grid, MaxR, MaxC) ->
    PlayerQ = queue:new(),
    PlayerVisited = sets:new(),
    PushingPositions = [],

    PlayerQ1 = queue:in(StartPlayerPos, PlayerQ),
    PlayerVisited1 = sets:add(StartPlayerPos, PlayerVisited),

    find_reachable_bfs(PlayerQ1, PlayerVisited1, PushingPositions, BoxPos, Grid, MaxR, MaxC).

find_reachable_bfs(PlayerQ, PlayerVisited, PushingPositions, BoxPos, Grid, MaxR, MaxC) ->
    case queue:out(PlayerQ) of
        {{value, CurrentPlayerPos}, PlayerQ_rest} ->
            {CurrentPx, CurrentPy} = CurrentPlayerPos,

            NewPushingPositions = if is_adjacent(CurrentPlayerPos, BoxPos) ->
                                    [CurrentPlayerPos | PushingPositions];
                                  true ->
                                    PushingPositions
                                  end,

            {NextPlayerQ, NextPlayerVisited} = lists:foldl(fun({Dr, Dc}, {PQ, PV}) ->
                NextPlayerPos = {CurrentPx + Dr, CurrentPy + Dc},
                if is_valid_player_move(Grid, NextPlayerPos, MaxR, MaxC, BoxPos) andalso not sets:is_element(NextPlayerPos, PV) ->
                    sets:add(NextPlayerPos, PV),
                    queue:in(NextPlayerPos, PQ);
                true ->
                    {PQ, PV}
                end
            end, {PlayerQ_rest, PlayerVisited}, ?DIRS),

            find_reachable_bfs(NextPlayerQ, NextPlayerVisited, NewPushingPositions, BoxPos, Grid, MaxR, MaxC);
        {empty, _} ->
            PushingPositions
    end.
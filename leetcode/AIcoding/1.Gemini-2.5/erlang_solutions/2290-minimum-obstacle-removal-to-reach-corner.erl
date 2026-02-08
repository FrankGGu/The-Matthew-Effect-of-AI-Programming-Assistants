-module(solution).
-export([min_obstacle_removal/1]).

min_obstacle_removal(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    TargetR = Rows - 1,
    TargetC = Cols - 1,

    DR = [-1, 1, 0, 0],
    DC = [0, 0, -1, 1],

    InitialObstacles = get_grid_val(Grid, 0, 0),

    Q_initial = 
        if InitialObstacles == 0 -> deque_push_front({{0, 0}, 0}, deque_new());
           true -> deque_push_back({{0, 0}, 1}, deque_new())
        end,

    Dist_initial = gb_trees:insert({0, 0}, InitialObstacles, gb_trees:empty()),

    bfs(Grid, Rows, Cols, TargetR, TargetC, DR, DC, Q_initial, Dist_initial).

bfs(Grid, Rows, Cols, TargetR, TargetC, DR, DC, Q, Dist) ->
    case deque_pop(Q) of
        {empty, _} ->
            error("BFS queue became empty before reaching target.");
        {{R, C}, D}, NewQ ->
            case gb_trees:lookup({R, C}, Dist) of
                {value, ExistingD} when D > ExistingD ->
                    bfs(Grid, Rows, Cols, TargetR, TargetC, DR, DC, NewQ, Dist);
                _ ->
                    if R == TargetR andalso C == TargetC ->
                        D;
                    true ->
                        Acc = #{q => NewQ, dist => Dist},
                        FinalAcc = lists:foldl(fun(I, CurrentAcc) ->
                                        NR = R + lists:nth(I, DR),
                                        NC = C + lists:nth(I, DC),

                                        if NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                                            ObstacleCost = get_grid_val(Grid, NR, NC),
                                            NewD = D + ObstacleCost,

                                            CurrentDist = maps:get(dist, CurrentAcc),

                                            case gb_trees:lookup({NR, NC}, CurrentDist) of
                                                {value, ExistingNeighborD} when NewD >= ExistingNeighborD ->
                                                    CurrentAcc;
                                                _ ->
                                                    NewDist = gb_trees:insert({NR, NC}, NewD, CurrentDist),
                                                    CurrentQ = maps:get(q, CurrentAcc),
                                                    NewQ_pushed = 
                                                        if ObstacleCost == 0 -> deque_push_front({{NR, NC}, NewD}, CurrentQ);
                                                           true -> deque_push_back({{NR, NC}, NewD}, CurrentQ)
                                                        end,
                                                    maps:put(q, NewQ_pushed, maps:put(dist, NewDist, CurrentAcc))
                                            end;
                                        true ->
                                            CurrentAcc
                                        end
                                end, Acc, lists:seq(1, 4)),

                        bfs(Grid, Rows, Cols, TargetR, TargetC, DR, DC, maps:get(q, FinalAcc), maps:get(dist, FinalAcc))
            end
    end.

get_grid_val(Grid, R, C) ->
    lists:nth(C+1, lists:nth(R+1, Grid)).

deque_new() -> {[], []}.
deque_is_empty({[], []}) -> true;
deque_is_empty(_) -> false.

deque_push_front(Val, {Front, Back}) -> {[Val | Front], Back}.
deque_push_back(Val, {Front, Back}) -> {Front, [Val | Back]}.

deque_pop({[], []}) -> {empty, {[], []}};
deque_pop({[H | T], Back}) -> {H, {T, Back}};
deque_pop({[], Back}) ->
    ReversedBack = lists:reverse(Back),
    case ReversedBack of
        [] -> {empty, {[], []}};
        [H | T] -> {H, {T, []}}
    end.
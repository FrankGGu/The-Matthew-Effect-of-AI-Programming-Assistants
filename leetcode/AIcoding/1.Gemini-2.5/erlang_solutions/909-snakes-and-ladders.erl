-module(solution).
-export([snakesAndLadders/1]).

snakesAndLadders(Board) ->
    N = length(Board),
    Target = N * N,

    GetBoardValue = fun(K) ->
        R_from_bottom = (K - 1) div N,
        C_from_left = (K - 1) rem N,

        Actual_R = N - 1 - R_from_bottom,
        Actual_C = if R_from_bottom rem 2 == 0 -> C_from_left;
                   true -> N - 1 - C_from_left
                   end,

        lists:nth(Actual_C + 1, lists:nth(Actual_R + 1, Board))
    end,

    InitialQueue = queue:in({1, 0}, queue:new()),
    InitialVisited = sets:add_element(1, sets:new()),

    bfs(InitialQueue, InitialVisited, Target, N, GetBoardValue).

bfs(Q, Visited, Target, N, GetBoardValue) ->
    case queue:out(Q) of
        {{value, {Cell, Moves}}, RestQ} ->
            if Cell == Target ->
                Moves;
            true ->
                NextRolls = lists:seq(Cell + 1, min(Cell + 6, Target)),

                {NewQ, NewVisited} = lists:foldl(
                    fun(NextK, {AccQ, AccVisited}) ->
                        BoardValue = GetBoardValue(NextK),
                        Destination = if BoardValue == -1 -> NextK;
                                      true -> BoardValue
                                      end,

                        if not sets:is_element(Destination, AccVisited) ->
                            {queue:in({Destination, Moves + 1}, AccQ), sets:add_element(Destination, AccVisited)};
                        true ->
                            {AccQ, AccVisited}
                        end
                    end,
                    {RestQ, Visited},
                    NextRolls
                ),

                bfs(NewQ, NewVisited, Target, N, GetBoardValue)
            end;
        {empty, _} ->
            -1
    end.
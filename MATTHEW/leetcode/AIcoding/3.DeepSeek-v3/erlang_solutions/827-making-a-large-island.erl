-module(solution).
-export([largest_island/1]).

largest_island(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Colors = maps:new(),
    {Colors1, Max} = colorize(Grid, Colors, N, M, 2, 0),
    find_max(Grid, Colors1, N, M, Max).

colorize(Grid, Colors, N, M, Color, Max) ->
    colorize(Grid, Colors, N, M, Color, Max, 0, 0).

colorize(Grid, Colors, N, M, Color, Max, I, J) when I >= N ->
    {Colors, Max};
colorize(Grid, Colors, N, M, Color, Max, I, J) when J >= M ->
    colorize(Grid, Colors, N, M, Color, Max, I + 1, 0);
colorize(Grid, Colors, N, M, Color, Max, I, J) ->
    Row = lists:nth(I + 1, Grid),
    Val = lists:nth(J + 1, Row),
    if
        Val =:= 1 ->
            {NewColors, Size} = dfs(Grid, Colors, N, M, I, J, Color),
            NewMax = max(Max, Size),
            colorize(Grid, NewColors, N, M, Color + 1, NewMax, I, J + 1);
        true ->
            colorize(Grid, Colors, N, M, Color, Max, I, J + 1)
    end.

dfs(Grid, Colors, N, M, I, J, Color) ->
    case maps:is_key({I, J}, Colors) of
        true -> {Colors, 0};
        false ->
            Row = lists:nth(I + 1, Grid),
            Val = lists:nth(J + 1, Row),
            if
                Val =:= 0 -> {Colors, 0};
                true ->
                    Colors1 = maps:put({I, J}, Color, Colors),
                    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
                    {Colors2, Sum} = lists:foldl(
                        fun({Di, Dj}, {CAcc, SAcc}) ->
                            Ni = I + Di,
                            Nj = J + Dj,
                            if
                                Ni >= 0, Ni < N, Nj >= 0, Nj < M ->
                                    {C, S} = dfs(Grid, CAcc, N, M, Ni, Nj, Color),
                                    {C, SAcc + S};
                                true -> {CAcc, SAcc}
                            end
                        end,
                        {Colors1, 0},
                        Directions
                    ),
                    {Colors2, Sum + 1}
            end
    end.

find_max(Grid, Colors, N, M, Max) ->
    find_max(Grid, Colors, N, M, Max, 0, 0).

find_max(Grid, Colors, N, M, Max, I, J) when I >= N ->
    Max;
find_max(Grid, Colors, N, M, Max, I, J) when J >= M ->
    find_max(Grid, Colors, N, M, Max, I + 1, 0);
find_max(Grid, Colors, N, M, Max, I, J) ->
    Row = lists:nth(I + 1, Grid),
    Val = lists:nth(J + 1, Row),
    if
        Val =:= 0 ->
            Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
            UniqueColors = lists:foldl(
                fun({Di, Dj}, Acc) ->
                    Ni = I + Di,
                    Nj = J + Dj,
                    if
                        Ni >= 0, Ni < N, Nj >= 0, Nj < M ->
                            case maps:get({Ni, Nj}, Colors, undefined) of
                                undefined -> Acc;
                                Color -> sets:add_element(Color, Acc)
                            end;
                        true -> Acc
                    end
                end,
                sets:new(),
                Directions
            ),
            Sum = sets:fold(
                fun(Color, Acc) ->
                    maps:get(Color, maps:get(color_sizes, Colors, #{}), 0) + Acc
                end,
                1,
                UniqueColors
            ),
            NewMax = max(Max, Sum),
            find_max(Grid, Colors, N, M, NewMax, I, J + 1);
        true ->
            find_max(Grid, Colors, N, M, Max, I, J + 1)
    end.
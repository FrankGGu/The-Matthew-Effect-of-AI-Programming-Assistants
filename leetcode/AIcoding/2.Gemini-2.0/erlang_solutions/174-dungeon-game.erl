-module(dungeon_game).
-export([calculate_minimum_hp/1]).

calculate_minimum_hp(Dungeon) ->
    Rows = length(Dungeon),
    Cols = length(hd(Dungeon)),
    dp(Dungeon, Rows, Cols).

dp(Dungeon, Rows, Cols) ->
    DP = array:new([Rows, Cols], {undefined}),

    LastRow = Rows - 1,
    LastCol = Cols - 1,

    array:set({LastRow, LastCol}, max(1, 1 - lists:nth(LastCol + 1, lists:nth(LastRow + 1, Dungeon))), DP),

    % Initialize last row
    for(Col <- lists:seq(LastCol - 1, 0, -1)),
        do
            HealthNeeded = max(1, array:get({LastRow, Col + 1}, DP) - lists:nth(Col + 1, lists:nth(LastRow + 1, Dungeon))),
            array:set({LastRow, Col}, HealthNeeded, DP)
        end,

    % Initialize last column
    for(Row <- lists:seq(LastRow - 1, 0, -1)),
        do
            HealthNeeded = max(1, array:get({Row + 1, LastCol}, DP) - lists:nth(LastCol + 1, lists:nth(Row + 1, Dungeon))),
            array:set({Row, LastCol}, HealthNeeded, DP)
        end,

    % Fill the rest of the table
    for(Row <- lists:seq(LastRow - 1, 0, -1)),
        do
            for(Col <- lists:seq(LastCol - 1, 0, -1)),
            do
                DownHealth = array:get({Row + 1, Col}, DP),
                RightHealth = array:get({Row, Col + 1}, DP),

                HealthNeeded = max(1, min(DownHealth, RightHealth) - lists:nth(Col + 1, lists:nth(Row + 1, Dungeon))),
                array:set({Row, Col}, HealthNeeded, DP)
            end
        end,

    array:get({0, 0}, DP).
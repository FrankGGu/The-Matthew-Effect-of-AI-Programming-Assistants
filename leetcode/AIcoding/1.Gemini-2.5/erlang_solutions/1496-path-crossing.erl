-module(solution).
-export([is_path_crossing/1]).

-spec is_path_crossing(Path :: unicode:unicode_binary()) -> boolean().
is_path_crossing(Path) ->
    InitialPos = {0, 0},
    InitialVisited = sets:add(InitialPos, sets:new()),
    Chars = unicode:characters_to_list(Path),
    solve(Chars, 0, 0, InitialVisited).

solve([], _CurrentX, _CurrentY, _Visited) ->
    false;
solve([H|T], CurrentX, CurrentY, Visited) ->
    {NewX, NewY} = case H of
        $N -> {CurrentX, CurrentY + 1};
        $S -> {CurrentX, CurrentY - 1};
        $E -> {CurrentX + 1, CurrentY};
        $W -> {CurrentX - 1, CurrentY}
    end,
    NewPos = {NewX, NewY},
    if
        sets:is_element(NewPos, Visited) ->
            true;
        true ->
            solve(T, NewX, NewY, sets:add(NewPos, Visited))
    end.
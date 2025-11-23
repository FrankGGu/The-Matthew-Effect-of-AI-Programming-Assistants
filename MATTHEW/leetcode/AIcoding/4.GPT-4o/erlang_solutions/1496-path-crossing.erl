-module(solution).
-export([is_path_crossing/1]).

is_path_crossing(Path) ->
    is_path_crossing(Path, {0, 0}, maps:from_list([{ {0, 0}, true}])).

is_path_crossing([], _, Visited) -> false;
is_path_crossing([H | T], {X, Y}, Visited) ->
    {NewX, NewY} = case H of
        $N -> {X, Y + 1};
        $S -> {X, Y - 1};
        $E -> {X + 1, Y};
        $W -> {X - 1, Y}
    end,
    if 
        maps:is_key({NewX, NewY}, Visited) ->
            true;
        true ->
            is_path_crossing(T, {NewX, NewY}, maps:put({NewX, NewY}, true, Visited))
    end.
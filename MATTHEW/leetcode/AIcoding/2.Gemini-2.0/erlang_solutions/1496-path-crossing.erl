-module(path_crossing).
-export([is_path_crossing/1]).

is_path_crossing(Path) ->
    is_path_crossing(Path, {0, 0}, [{0, 0}]).

is_path_crossing([], _, _) ->
    false;
is_path_crossing([H|T], {X, Y}, Visited) ->
    {NewX, NewY} = case H of
        $N -> {X, Y + 1};
        $S -> {X, Y - 1};
        $E -> {X + 1, Y};
        $W -> {X - 1, Y}
    end,
    case lists:member({NewX, NewY}, Visited) of
        true ->
            true;
        false ->
            is_path_crossing(T, {NewX, NewY}, [{NewX, NewY}|Visited])
    end.
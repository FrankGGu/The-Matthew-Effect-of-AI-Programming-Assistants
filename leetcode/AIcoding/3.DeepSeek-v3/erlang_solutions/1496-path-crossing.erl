-spec is_path_crossing(Path :: unicode:unicode_binary()) -> boolean().
is_path_crossing(Path) ->
    Initial = {0, 0},
    Visited = sets:from_list([Initial]),
    check_path(Path, Initial, Visited).

check_path(<<>>, _, _) -> false;
check_path(<<Direction:8, Rest/binary>>, {X, Y}, Visited) ->
    NewPos = case Direction of
        $N -> {X, Y + 1};
        $S -> {X, Y - 1};
        $E -> {X + 1, Y};
        $W -> {X - 1, Y}
    end,
    case sets:is_element(NewPos, Visited) of
        true -> true;
        false -> 
            NewVisited = sets:add_element(NewPos, Visited),
            check_path(Rest, NewPos, NewVisited)
    end.
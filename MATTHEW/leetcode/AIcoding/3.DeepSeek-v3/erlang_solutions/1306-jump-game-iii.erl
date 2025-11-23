-spec can_reach(Arr :: [integer()], Start :: integer()) -> boolean().
can_reach(Arr, Start) ->
    N = length(Arr),
    Visited = array:new([{size, N}, {default, false}]),
    can_reach_helper(Arr, Start, Visited).

can_reach_helper(Arr, Pos, Visited) ->
    N = length(Arr),
    case Pos < 0 orelse Pos >= N orelse array:get(Pos, Visited) of
        true -> false;
        false ->
            Value = lists:nth(Pos + 1, Arr),
            case Value =:= 0 of
                true -> true;
                false ->
                    NewVisited = array:set(Pos, true, Visited),
                    can_reach_helper(Arr, Pos + Value, NewVisited) orelse
                    can_reach_helper(Arr, Pos - Value, NewVisited)
            end
    end.
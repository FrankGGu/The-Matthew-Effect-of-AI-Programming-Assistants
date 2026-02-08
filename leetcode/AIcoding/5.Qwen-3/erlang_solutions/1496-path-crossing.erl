-module(path_crossing).
-export([is_path_crossing/1]).

is_path_crossing(Path) ->
    is_path_crossing(Path, {0, 0}, #{ {0, 0} => true }).

is_path_crossing([], _, _) ->
    false;
is_path_crossing([H | T], {X, Y}, Visited) ->
    NewPos = case H of
        $U -> {X, Y + 1};
        $D -> {X, Y - 1};
        $R -> {X + 1, Y};
        $L -> {X - 1, Y}
    end,
    case maps:is_key(NewPos, Visited) of
        true -> true;
        false ->
            is_path_crossing(T, NewPos, maps:put(NewPos, true, Visited))
    end.
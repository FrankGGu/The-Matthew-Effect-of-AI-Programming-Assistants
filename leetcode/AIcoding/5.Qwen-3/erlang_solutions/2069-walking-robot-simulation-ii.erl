-module(robot_simulation_ii).
-export([execute/1]).

execute(Instructions) ->
    execute(Instructions, {0, 0}, 0, #{0 => {0, 0}, 1 => {0, 1}, 2 => {1, 0}, 3 => {0, -1}}, #{}).

execute([], _Pos, _Dir, _Dirs, _Visited) ->
    ok;
execute([H | T], {X, Y}, Dir, Dirs, Visited) ->
    case H of
        left ->
            NewDir = (Dir + 3) rem 4,
            execute(T, {X, Y}, NewDir, Dirs, Visited);
        right ->
            NewDir = (Dir + 1) rem 4,
            execute(T, {X, Y}, NewDir, Dirs, Visited);
        back ->
            {DX, DY} = maps:get(Dir, Dirs),
            NewX = X - DX,
            NewY = Y - DY,
            execute(T, {NewX, NewY}, Dir, Dirs, Visited);
        forward ->
            {DX, DY} = maps:get(Dir, Dirs),
            NewX = X + DX,
            NewY = Y + DY,
            Key = {NewX, NewY},
            case maps:is_key(Key, Visited) of
                true ->
                    ok;
                false ->
                    execute(T, {NewX, NewY}, Dir, Dirs, maps:put(Key, true, Visited))
            end
    end.
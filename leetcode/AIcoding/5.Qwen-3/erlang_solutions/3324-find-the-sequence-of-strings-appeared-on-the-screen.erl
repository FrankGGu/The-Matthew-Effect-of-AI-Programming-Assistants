-module(solution).
-export([find_sequence/1]).

find_sequence(Commands) ->
    L = lists:reverse(Commands),
    find_sequence(L, [], []).

find_sequence([], _, Acc) ->
    lists:reverse(Acc);
find_sequence([<<"Back">> | T], Current, Acc) ->
    case Current of
        [] -> find_sequence(T, Current, Acc);
        _ -> find_sequence(T, tl(Current), Acc)
    end;
find_sequence([Cmd | T], Current, Acc) ->
    NewCurrent = [Cmd | Current],
    find_sequence(T, NewCurrent, [Cmd | Acc]).
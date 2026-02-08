-module(swap_for_longest_repeated_character_substring).
-export([main/0]).

main() ->
    Input = io:get_line([]),
    Str = string:strip(Input, both, $\n),
    Result = solve(Str),
    io:format("~p~n", [Result]).

solve(Str) ->
    N = length(Str),
    MaxLen = 0,
    Map = maps:new(),
    solve(Str, N, 0, MaxLen, Map).

solve(_, _, I, MaxLen, _) when I >= 1 ->
    MaxLen;
solve(Str, N, I, MaxLen, Map) ->
    C = string:at(Str, I),
    Count = maps:get(C, Map, 0),
    NewMap = maps:put(C, Count + 1, Map),
    NextI = I + 1,
    case Count of
        0 ->
            solve(Str, N, NextI, MaxLen, NewMap);
        _ ->
            CurrentLen = Count + 1,
            NewMax = max(MaxLen, CurrentLen),
            solve(Str, N, NextI, NewMax, NewMap)
    end.
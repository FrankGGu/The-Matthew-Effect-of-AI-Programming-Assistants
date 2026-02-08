-module(solution).
-export([find_latest_group_size_m/2]).

find_latest_group_size_m(Flags, M) ->
    find_latest_group_size_m(Flags, M, 0, 1, dict:new()).

find_latest_group_size_m([], _, _, _, _) ->
    0;
find_latest_group_size_m([H | T], M, Count, Pos, D) ->
    case H of
        1 ->
            Left = if Pos > 1 -> dict:get(Pos - 1, D, 0); true -> 0 end,
            Right = if Pos < length(Flags) -> dict:get(Pos + 1, D, 0); true -> 0 end,
            NewCount = Count + 1 + Left + Right,
            NewD = dict:store(Pos, NewCount, D),
            if
                NewCount == M ->
                    find_latest_group_size_m(T, M, NewCount, Pos + 1, NewD);
                true ->
                    find_latest_group_size_m(T, M, Count, Pos + 1, NewD)
            end;
        _ ->
            find_latest_group_size_m(T, M, Count, Pos + 1, D)
    end.
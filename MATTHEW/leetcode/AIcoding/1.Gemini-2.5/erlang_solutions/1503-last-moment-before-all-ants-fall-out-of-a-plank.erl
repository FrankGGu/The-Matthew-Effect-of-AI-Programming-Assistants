-module(solution).
-export([get_last_moment/3]).

get_last_moment(N, Left, Right) ->
    MaxLeftTime =
        case Left of
            [] -> 0;
            _ -> lists:max(Left)
        end,

    MaxRightTime =
        case Right of
            [] -> 0;
            _ -> lists:max(lists:map(fun(Pos) -> N - Pos end, Right))
        end,

    max(MaxLeftTime, MaxRightTime).
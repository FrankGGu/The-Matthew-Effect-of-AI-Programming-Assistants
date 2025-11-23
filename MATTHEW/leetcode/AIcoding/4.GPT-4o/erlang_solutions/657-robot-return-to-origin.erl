-module(solution).
-export([judgeCircle/1]).

judgeCircle(Moves) ->
    {X, Y} = lists:foldl(fun(C, {X, Y}) ->
        case C of
            $U -> {X, Y + 1};
            $D -> {X, Y - 1};
            $L -> {X - 1, Y};
            $R -> {X + 1, Y}
        end
    end, {0, 0}, Moves),
    X =:= 0 andalso Y =:= 0.
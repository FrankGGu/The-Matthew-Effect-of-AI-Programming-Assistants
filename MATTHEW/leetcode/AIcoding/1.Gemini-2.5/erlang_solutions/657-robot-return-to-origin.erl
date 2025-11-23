-module(solution).
-export([robot_return_to_origin/1]).

-spec robot_return_to_origin(Moves :: binary()) -> boolean().
robot_return_to_origin(Moves) ->
    FinalPos = lists:foldl(
        fun(MoveChar, {X, Y}) ->
            case MoveChar of
                $U -> {X, Y + 1};
                $D -> {X, Y - 1};
                $L -> {X - 1, Y};
                $R -> {X + 1, Y};
                _  -> {X, Y}
            end
        end,
        {0, 0},
        binary_to_list(Moves)
    ),
    FinalPos == {0, 0}.
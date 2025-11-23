-module(solution).
-export([least_bricks/1]).

least_bricks(Wall) ->
    Map = lists:foldl(
        fun(Row, Acc) ->
            Width = lists:foldl(
                fun(Len, W) -> W + Len end,
                0,
                Row
            ),
            lists:foldl(
                fun(Len, {W, M}) ->
                    NewW = W + Len,
                    case maps:is_key(NewW, M) of
                        true ->
                            maps:update(NewW, maps:get(NewW, M) + 1, M);
                        false ->
                            maps:put(NewW, 1, M)
                    end,
                    {NewW, M}
                end,
                {0, Acc},
                Row
            )
        end,
        #{},
        Wall
    ),
    MaxValue = lists:foldl(
        fun({_, V}, Max) ->
            case V > Max of
                true -> V;
                false -> Max
            end
        end,
        0,
        maps:to_list(maps:remove(0, Map))
    ),
    length(Wall) - MaxValue.
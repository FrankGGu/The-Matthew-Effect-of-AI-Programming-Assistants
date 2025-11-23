-module(max_balls_in_box).
-export([max_balls/1]).

max_balls(Balls) ->
    Count = maps:new(),
    lists:foldl(fun(Ball, Acc) ->
        Key = ball_key(Ball),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, Count, Balls),
    maps:values(Count) ++ [0],
    lists:max(maps:values(Count)).

ball_key(Ball) ->
    X = Ball div 100,
    Y = Ball rem 100,
    X + Y.
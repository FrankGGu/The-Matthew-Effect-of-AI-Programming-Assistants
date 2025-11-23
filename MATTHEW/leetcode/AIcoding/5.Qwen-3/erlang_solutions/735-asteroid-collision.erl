-module(asteroid_collision).
-export([collision/1]).

collision(Ast) ->
    collision(Ast, []).

collision([], Acc) ->
    lists:reverse(Acc);
collision([A | Rest], []) ->
    collision(Rest, [A]);
collision([A | Rest], [B | Acc]) when A > 0 andalso B < 0 ->
    if
        A > abs(B) ->
            collision(Rest, Acc);
        A == abs(B) ->
            collision(Rest, Acc);
        true ->
            collision([A | Rest], Acc)
    end;
collision([A | Rest], [B | Acc]) ->
    collision([A | Rest], [B | Acc]).
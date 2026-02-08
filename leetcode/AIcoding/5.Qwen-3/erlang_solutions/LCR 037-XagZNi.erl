-module(planet_collision).
-export([asteroid_collision/1]).

asteroid_collision(Ast) ->
    collide(Ast, []).

collide([], Acc) ->
    lists:reverse(Acc);
collide([H | T], Acc) ->
    case Acc of
        [] ->
            collide(T, [H]);
        [A | _] when A > 0 andalso H < 0 ->
            if
                A > -H ->
                    collide(T, Acc);
                A == -H ->
                    collide(T, Acc -- [A]);
                true ->
                    collide(T, [H | Acc -- [A]])
            end;
        _ ->
            collide(T, [H | Acc])
    end.
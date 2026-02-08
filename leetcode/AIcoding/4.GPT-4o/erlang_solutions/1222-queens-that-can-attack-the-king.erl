-module(solution).
-export([queens_attack_king/2]).

queens_attack_king(Queens, King) ->
    QueensList = lists:map(fun({X, Y}) -> {X, Y} end, Queens),
    KingX = element(1, King),
    KingY = element(2, King),
    AttackableQueens = lists:filter(fun(Queen) ->
        can_attack(Queen, KingX, KingY)
    end, QueensList),
    AttackableQueens.

can_attack({QX, QY}, KX, KY) ->
    QX =:= KX orelse QY =:= KY orelse abs(QX - KX) =:= abs(QY - KY).
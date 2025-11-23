-module(queens_that_can_attack_the_king).
-export([queensAttacktheKing/1]).

queensAttacktheKing(Queens) ->
    King = {0, 0},
    queensAttacktheKing(Queens, King, []).

queensAttacktheKing([], _, Acc) ->
    lists:reverse(Acc);
queensAttacktheKing([{Qx, Qy} | T], {Kx, Ky}, Acc) ->
    case can_attack({Qx, Qy}, {Kx, Ky}) of
        true -> queensAttacktheKing(T, {Kx, Ky}, [{Qx, Qy} | Acc]);
        false -> queensAttacktheKing(T, {Kx, Ky}, Acc)
    end.

can_attack({Qx, Qy}, {Kx, Ky}) ->
    Qx == Kx orelse Qy == Ky orelse abs(Qx - Kx) == abs(Qy - Ky).
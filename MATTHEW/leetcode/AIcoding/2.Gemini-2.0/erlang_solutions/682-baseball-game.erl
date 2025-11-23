-module(baseball_game).
-export([calPoints/1]).

calPoints(Ops) ->
    calculate_score(Ops, []).

calculate_score([], Acc) ->
    sum(Acc);
calculate_score(["+" | Rest], Acc) ->
    case length(Acc) of
        0 -> calculate_score(Rest, [0 | Acc]);
        1 -> calculate_score(Rest, [hd(Acc) + hd(Acc) | Acc]);
        _ ->
            [A, B | _] = Acc,
            calculate_score(Rest, [A + B | Acc])
    end;
calculate_score(["D" | Rest], Acc) ->
    case length(Acc) of
        0 -> calculate_score(Rest, [0 | Acc]);
        _ -> calculate_score(Rest, [2 * hd(Acc) | Acc])
    end;
calculate_score(["C" | Rest], Acc) ->
    case length(Acc) of
        0 -> calculate_score(Rest, Acc);
        _ -> calculate_score(Rest, tl(Acc))
    end;
calculate_score([Num | Rest], Acc) ->
    calculate_score(Rest, [list_to_integer(Num) | Acc]).

sum([]) -> 0;
sum([H | T]) -> H + sum(T).
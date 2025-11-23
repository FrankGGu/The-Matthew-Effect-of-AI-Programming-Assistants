-module(push_dominoes).
-export([push_dominoes/1]).

push_dominoes(Dominoes) ->
    Len = length(Dominoes),
    Left = lists:seq(0, Len - 1),
    Right = lists:seq(Len - 1, 0, -1),
    LeftScores = calc_left(Dominoes, Left, []),
    RightScores = calc_right(Dominoes, Right, []),
    lists:zipwith(fun(L, R) -> 
        case L of
            0 -> $L;
            _ -> 
                case R of
                    0 -> $R;
                    _ -> 
                        if L < R -> $L;
                           L > R -> $R;
                           true -> $.
                        end
                end
        end
    end, LeftScores, RightScores).

calc_left(_, [], Acc) -> lists:reverse(Acc);
calc_left(Dominoes, [I | Is], Acc) ->
    case lists:nth(I + 1, Dominoes) of
        $L -> calc_left(Dominoes, Is, [0 | Acc]);
        $R -> calc_left(Dominoes, Is, [1 | Acc]);
        _ -> 
            case Acc of
                [] -> calc_left(Dominoes, Is, [0 | Acc]);
                [H | T] -> calc_left(Dominoes, Is, [H + 1 | Acc])
            end
    end.

calc_right(_, [], Acc) -> lists:reverse(Acc);
calc_right(Dominoes, [I | Is], Acc) ->
    case lists:nth(I - 1, Dominoes) of
        $R -> calc_right(Dominoes, Is, [0 | Acc]);
        $L -> calc_right(Dominoes, Is, [1 | Acc]);
        _ -> 
            case Acc of
                [] -> calc_right(Dominoes, Is, [0 | Acc]);
                [H | T] -> calc_right(Dominoes, Is, [H + 1 | Acc])
            end
    end.
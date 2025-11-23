-module(solution).
-export([maximize_confusion/2]).

maximize_confusion(AnswerKey, Target) ->
    Max = 0,
    Len = length(AnswerKey),
    Count = fun(C, T) -> 
        case C of
            $T -> T + 1;
            _ -> T
        end
    end,
    Loop = fun(I, Acc) ->
        if
            I >= Len -> Acc;
            true ->
                Current = lists:nth(I+1, AnswerKey),
                NewAcc = case Current of
                    $T -> Acc + 1;
                    _ -> Acc
                end,
                Loop(I+1, NewAcc)
        end
    end,
    Total = Loop(0, 0),
    case Target of
        $T -> Total;
        _ -> Len - Total
    end.
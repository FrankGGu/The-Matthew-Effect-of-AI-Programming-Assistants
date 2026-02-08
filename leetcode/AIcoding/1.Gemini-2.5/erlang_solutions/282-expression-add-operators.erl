-module(solution).
-export([addOperators/2]).

addOperators(Num, Target) ->
    backtrack(Num, Target, 0, [], 0, 0, []).

backtrack(Num, Target, Idx, CurrentExpr, CurrentVal, LastOperand, Acc) ->
    NumLen = length(Num),
    if
        Idx == NumLen ->
            if CurrentVal == Target ->
                [lists:reverse(CurrentExpr) | Acc];
            else
                Acc
            end;
        true ->
            lists:foldl(fun(EndIdx, CurrentAcc) ->
                SubNumStr = lists:sublist(Num, Idx + 1, EndIdx - Idx),
                if
                    EndIdx - Idx > 1 andalso hd(SubNumStr) == $0 ->
                        CurrentAcc;
                    true ->
                        NumVal = list_to_integer(SubNumStr),
                        NumValStr = integer_to_list(NumVal),
                        if
                            Idx == 0 ->
                                backtrack(Num, Target, EndIdx, NumValStr, NumVal, NumVal, CurrentAcc);
                            true ->
                                Acc1 = backtrack(Num, Target, EndIdx, NumValStr ++ [$+ | CurrentExpr], CurrentVal + NumVal, NumVal, CurrentAcc),
                                Acc2 = backtrack(Num, Target, EndIdx, NumValStr ++ [$- | CurrentExpr], CurrentVal - NumVal, -NumVal, Acc1),
                                Acc3 = backtrack(Num, Target, EndIdx, NumValStr ++ [$* | CurrentExpr], CurrentVal - LastOperand + (LastOperand * NumVal), LastOperand * NumVal, Acc2),
                                Acc3
                        end
                end
            end, Acc, lists:seq(Idx + 1, NumLen))
    end.
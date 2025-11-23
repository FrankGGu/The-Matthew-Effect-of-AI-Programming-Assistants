-module(solution).
-export([evaluate/1, min_operations_to_flip/1]).

evaluate(Expr) ->
    {Val, _} = eval(Expr, 0, #{}),
    Val.

eval([], Pos, Mem) ->
    {0, Pos, Mem};
eval([$( | Rest], Pos, Mem) ->
    {Val1, Pos1, Mem1} = eval(Rest, Pos + 1, Mem),
    case lists:nth(Pos1, Rest) of
        $) ->
            {Val1, Pos1 + 1, Mem1};
        Op ->
            {Val2, Pos2, Mem2} = eval(Rest, Pos1 + 1, Mem1),
            NewVal = case Op of
                $& -> Val1 band Val2;
                $| -> Val1 bor Val2
            end,
            {NewVal, Pos2, Mem2}
    end;
eval([C | Rest], Pos, Mem) when C >= $0, C =< $1 ->
    {C - $0, Pos + 1, Mem};
eval([Op | Rest], Pos, Mem) when Op == $&; Op == $| ->
    {Val1, Pos1, Mem1} = eval(Rest, Pos + 1, Mem),
    {Val1, Pos1, Mem1}.

min_operations_to_flip(Expr) ->
    {Val, Cost} = dp(Expr, 0, #{}),
    Cost.

dp([], Pos, Mem) ->
    {{0, 1}, {1, 1}, Pos, Mem};
dp([$( | Rest], Pos, Mem) ->
    {{Val1, Cost1}, {NotVal1, NotCost1}, Pos1, Mem1} = dp(Rest, Pos + 1, Mem),
    case lists:nth(Pos1, Rest) of
        $) ->
            {{Val1, Cost1}, {NotVal1, NotCost1}, Pos1 + 1, Mem1};
        Op ->
            {{Val2, Cost2}, {NotVal2, NotCost2}, Pos2, Mem2} = dp(Rest, Pos1 + 1, Mem1),
            case Op of
                $& ->
                    Val = Val1 band Val2,
                    NotVal = NotVal1 bor NotVal2,
                    Cost = min(min(Cost1 + Cost2, Cost1 + NotCost2), NotCost1 + Cost2),
                    NotCost = min(min(NotCost1 + NotCost2, NotCost1 + Cost2), Cost1 + NotCost2),
                    {{Val, Cost}, {NotVal, NotCost}, Pos2, Mem2};
                $| ->
                    Val = Val1 bor Val2,
                    NotVal = NotVal1 band NotVal2,
                    Cost = min(min(Cost1 + Cost2, Cost1 + NotCost2), NotCost1 + Cost2),
                    NotCost = min(min(NotCost1 + NotCost2, NotCost1 + Cost2), Cost1 + NotCost2),
                    {{Val, Cost}, {NotVal, NotCost}, Pos2, Mem2}
            end
    end;
dp([C | Rest], Pos, Mem) when C >= $0, C =< $1 ->
    Val = C - $0,
    NotVal = 1 - Val,
    Cost = 1,
    NotCost = 1,
    {{Val, Cost}, {NotVal, NotCost}, Pos + 1, Mem};
dp([Op | Rest], Pos, Mem) when Op == $&; Op == $| ->
    dp(Rest, Pos + 1, Mem).
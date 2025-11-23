-module(basic_calculator).
-export([calculate/1]).

calculate(S) ->
    {Result, _} = evaluate(S, 0, [], []),
    Result.

evaluate([], Index, Ops, Nums) ->
    {calculate_stack(Ops, Nums), Index};
evaluate([C | Rest], Index, Ops, Nums) when C =:= $  ->
    evaluate(Rest, Index + 1, Ops, Nums);
evaluate([C | Rest], Index, Ops, Nums) when C >= $0, C =< $9 ->
    {Num, NewIndex} = collect_number([C | Rest], Index),
    evaluate(string:substr(Rest, NewIndex - Index), NewIndex, Ops, [Num | Nums]);
evaluate([$( | Rest], Index, Ops, Nums) ->
    evaluate(Rest, Index + 1, [$( | Ops], Nums);
evaluate([$) | Rest], Index, Ops, Nums) ->
    {NewOps, NewNums} = process_parenthesis(Ops, Nums),
    evaluate(Rest, Index + 1, NewOps, NewNums);
evaluate([C | Rest], Index, Ops, Nums) when C =:= $+; C =:= $- ->
    NewOps = case Ops of
                 [Op | _] when Op =/= $( -> [Op | Ops];
                 _ -> Ops
             end,
    evaluate(Rest, Index + 1, [C | Ops], Nums).

collect_number(Str, Index) ->
    collect_number(Str, Index, 0).

collect_number([C | Rest], Index, Num) when C >= $0, C =< $9 ->
    collect_number(Rest, Index + 1, Num * 10 + (C - $0));
collect_number(_, Index, Num) ->
    {Num, Index}.

process_parenthesis(Ops, Nums) ->
    {NewOps, [Num | NewNums]} = calculate_stack(Ops, Nums),
    {tl(NewOps), [Num | NewNums]}.

calculate_stack([], [Num]) ->
    {[], [Num]};
calculate_stack([], Nums) ->
    {[], Nums};
calculate_stack([Op | Ops], [Num1, Num2 | Nums]) when Op =:= $+; Op =:= $- ->
    NewNum = case Op of
                 $+ -> Num2 + Num1;
                 $- -> Num2 - Num1
             end,
    calculate_stack(Ops, [NewNum | Nums]);
calculate_stack(Ops, Nums) ->
    {Ops, Nums}.
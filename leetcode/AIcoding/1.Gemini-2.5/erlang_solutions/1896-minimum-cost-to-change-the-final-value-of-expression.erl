-module(solution).
-export([minimum_cost_to_change_final_value/1]).

-spec minimum_cost_to_change_final_value(Expression :: unicode:unicode_binary()) -> integer().
minimum_cost_to_change_final_value(Expression) ->
    Chars = unicode:characters_to_list(Expression),
    {FinalC0, FinalC1} = eval(Chars, [], []),
    erlang:min(FinalC0, FinalC1).

eval([], OperandStack, _OperatorStack) ->
    hd(OperandStack);
eval([Char | Rest], OperandStack, OperatorStack) ->
    case Char of
        $( ->
            eval(Rest, OperandStack, OperatorStack);
        $0 ->
            eval(Rest, [{0, 1} | OperandStack], OperatorStack);
        $1 ->
            eval(Rest, [{1, 0} | OperandStack], OperatorStack);
        $& ->
            eval(Rest, OperandStack, [and | OperatorStack]);
        $| ->
            eval(Rest, OperandStack, [or | OperatorStack]);
        $) ->
            {R_C0, R_C1} = hd(OperandStack),
            OperandStack1 = tl(OperandStack),
            {L_C0, L_C1} = hd(OperandStack1),
            OperandStack2 = tl(OperandStack1),

            Op = hd(OperatorStack),
            OperatorStack1 = tl(OperatorStack),

            And_C0 = min3(L_C0 + R_C0, L_C0 + R_C1, L_C1 + R_C0),
            And_C1 = L_C1 + R_C1,

            Or_C0 = L_C0 + R_C0,
            Or_C1 = min3(L_C0 + R_C1, L_C1 + R_C0, L_C1 + R_C1),

            {NewC0, NewC1} =
                case Op of
                    and ->
                        {erlang:min(And_C0, Or_C0 + 1), erlang:min(And_C1, Or_C1 + 1)};
                    or ->
                        {erlang:min(Or_C0, And_C0 + 1), erlang:min(Or_C1, And_C1 + 1)}
                end,
            eval(Rest, [{NewC0, NewC1} | OperandStack2], OperatorStack1)
    end.

min3(A, B, C) ->
    erlang:min(A, erlang:min(B, C)).
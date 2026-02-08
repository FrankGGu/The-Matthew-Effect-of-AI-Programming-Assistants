-module(solution).
-export([multiply/2]).

multiply(Num1, Num2) ->
    case {Num1, Num2} of
        {"0", _} -> "0";
        {_, "0"} -> "0";
        _ ->
            N1 = length(Num1),
            N2 = length(Num2),
            Pos = lists:duplicate(N1 + N2, 0),
            multiply_helper(Num1, Num2, N1 - 1, N2 - 1, Pos)
    end.

multiply_helper(_, _, -1, _, Pos) ->
    lists:flatten([integer_to_list(D) || D <- lists:dropwhile(fun(D) -> D == 0 end, Pos)]);
multiply_helper(Num1, Num2, I, J, Pos) when J >= 0 ->
    D1 = lists:nth(I + 1, Num1) - $0,
    D2 = lists:nth(J + 1, Num2) - $0,
    Sum = D1 * D2 + lists:nth(I + J + 2, Pos),
    NewPos = set_nth(I + J + 2, Sum rem 10, Pos),
    Carry = Sum div 10,
    NewPos2 = set_nth(I + J + 1, Carry + lists:nth(I + J + 1, NewPos), NewPos),
    multiply_helper(Num1, Num2, I, J - 1, NewPos2);
multiply_helper(Num1, Num2, I, -1, Pos) ->
    multiply_helper(Num1, Num2, I - 1, length(Num2) - 1, Pos).

set_nth(1, Val, [_ | T]) -> [Val | T];
set_nth(N, Val, [H | T]) -> [H | set_nth(N - 1, Val, T)].
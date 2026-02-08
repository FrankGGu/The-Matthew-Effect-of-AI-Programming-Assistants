-module(digit_operations).
-export([minimumOperations/2]).

minimumOperations(Num1, Num2) ->
    minimumOperations(integer_to_list(Num1), integer_to_list(Num2), 0).

minimumOperations(L1, L2, Acc) ->
    case {L1, L2} of
        {[], []} ->
            Acc;
        {[H1 | T1], [H2 | T2]} ->
            if H1 == H2 then
                minimumOperations(T1, T2, Acc)
            else
                V1 = list_to_integer([H1 | T1]);
                V2 = list_to_integer([H2 | T2]);

                if V1 > V2 then
                    minimumOperations(integer_to_list(V1 - 1), integer_to_list(V2), Acc + 1)
                else
                    minimumOperations(integer_to_list(V1 + 1), integer_to_list(V2), Acc + 1)
                end
            end;
        {[], _} ->
            minimumOperations([], [], Acc + length(L2));
        {_, []} ->
            minimumOperations([], [], Acc + length(L1))
    end.
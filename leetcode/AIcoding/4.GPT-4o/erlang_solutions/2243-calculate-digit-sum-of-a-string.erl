-module(solution).
-export([digit_sum/1]).

digit_sum(S) ->
    digit_sum_helper(S).

digit_sum_helper(S) ->
    case length(S) of
        0 -> S;
        _ ->
            Sum = lists:foldl(fun(C, Acc) -> Acc + (list_to_integer([C]) - $0) end, 0, S),
            New_S = integer_to_list(Sum),
            if
                length(New_S) > 1 -> digit_sum_helper(New_S);
                true -> New_S
            end
    end.
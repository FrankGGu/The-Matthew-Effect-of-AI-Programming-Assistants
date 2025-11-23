-module(alternating_digit_sum).
-export([alternate_digit_sum/1]).

alternate_digit_sum(N) ->
    Digits = integer_to_list(N),
    lists:foldl(fun(D, Acc) -> 
        case Acc of
            {Sign, Sum} ->
                NewSign = case Sign of
                    1 -> -1;
                    -1 -> 1
                end,
                {NewSign, Sum + (D - $0) * Sign}
        end
    end, {1, 0}, Digits),
    Sum = lists:last(lists:foldl(fun(D, Acc) -> 
        case Acc of
            {Sign, Sum} ->
                NewSign = case Sign of
                    1 -> -1;
                    -1 -> 1
                end,
                {NewSign, Sum + (D - $0) * Sign}
        end
    end, {1, 0}, Digits)),
    Sum.
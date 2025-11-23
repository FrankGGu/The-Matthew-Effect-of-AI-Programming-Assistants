-module(solution).
-export([num_dup_digits_at_most_n/1]).

num_dup_digits_at_most_n(N) ->
    L = integer_to_list(N),
    Len = length(L),
    Total = N + 1 - count_numbers_with_unique_digits(L, Len),
    Total.

count_numbers_with_unique_digits(L, Len) ->
    count_numbers_with_unique_digits(L, Len, 0, sets:new()).

count_numbers_with_unique_digits([], _, _, _) ->
    1;
count_numbers_with_unique_digits([H|T], Len, Pos, Used) ->
    Digit = H - $0,
    Start = case Pos of 0 -> 1; _ -> 0 end,
    Sum = lists:foldl(fun(D, Acc) ->
        case sets:is_element(D, Used) of
            true -> Acc;
            false -> Acc + count_remaining(Pos + 1, Len, sets:add_element(D, Used))
        end
    end, 0, lists:seq(Start, Digit - 1)),
    case sets:is_element(Digit, Used) of
        true -> Sum;
        false -> Sum + count_numbers_with_unique_digits(T, Len, Pos + 1, sets:add_element(Digit, Used))
    end.

count_remaining(Pos, Len, Used) ->
    Available = 10 - sets:size(Used),
    case Pos + 1 =< Len of
        true -> factorial(Available) div factorial(Available - (Len - Pos));
        false -> 0
    end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).
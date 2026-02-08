-module(solution).
-export([at_most_n_given_digit_set/2]).

at_most_n_given_digit_set(Digits, N) ->
    N_str = integer_to_list(N),
    N_length = length(N_str),
    Digits_length = length(Digits),
    Count1 = count_less_than(N_str, Digits, N_length, Digits_length),
    Count2 = count_equal(N_str, Digits, N_length, Digits_length),
    Count1 + Count2.

count_less_than(N_str, Digits, N_length, Digits_length) ->
    lists:foldl(fun(_, Acc) -> Acc + pow(Digits_length, N_length) end, 0, lists:seq(1, N_length - 1)).

count_equal(N_str, Digits, N_length, Digits_length) ->
    count_equal_helper(N_str, Digits, N_length, Digits_length, 0).

count_equal_helper(_, _, 0, _, Acc) -> Acc;
count_equal_helper(N_str, Digits, N_length, Digits_length, Acc) ->
    Current_digit = hd(N_str),
    Smaller_count = count_smaller(Current_digit, Digits),
    if
        Smaller_count > 0 -> 
            Acc + Smaller_count * pow(Digits_length, N_length - 1);
        true ->
            if
                lists:member(Current_digit, Digits) ->
                    count_equal_helper(tl(N_str), Digits, N_length - 1, Digits_length, Acc + 1);
                true ->
                    Acc
            end
    end.

count_smaller(Digit, Digits) ->
    lists:foldl(fun(D, Acc) -> if D < Digit -> Acc + 1; true -> Acc end end, 0, Digits).

pow(Base, Exponent) ->
    lists:foldl(fun(_, Acc) -> Acc * Base end, 1, lists:seq(1, Exponent)).
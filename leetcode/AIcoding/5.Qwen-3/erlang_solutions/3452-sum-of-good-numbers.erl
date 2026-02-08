-module(solution).
-export([sum_of_good_numbers/1]).

sum_of_good_numbers(N) ->
    sum_of_good_numbers(N, 0, 0).

sum_of_good_numbers(0, _, Sum) ->
    Sum;
sum_of_good_numbers(N, I, Sum) ->
    case is_good(I) of
        true ->
            sum_of_good_numbers(N-1, I+1, Sum + I);
        false ->
            sum_of_good_numbers(N, I+1, Sum)
    end.

is_good(X) ->
    is_good(X, X).

is_good(0, _) ->
    true;
is_good(X, Original) ->
    Digit = X rem 10,
    if
        Digit == 0 ->
            is_good(X div 10, Original);
        true ->
            case (Original rem Digit) of
                0 ->
                    is_good(X div 10, Original);
                _ ->
                    false
            end
    end.
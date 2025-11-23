-module(solution).
-export([sum_of_numbers_with_units_digit_k/2]).

sum_of_numbers_with_units_digit_k(Num, K) ->
    case Num =:= 0 of
        true -> 0;
        false ->
            case K of
                0 ->
                    case Num rem 10 =:= 0 of
                        true -> Num;
                        false -> -1
                    end;
                _ ->
                    find_sum(Num, K, 1)
            end
    end.

find_sum(Num, K, Count) ->
    Value = K * Count.
    case Value > Num of
        true -> -1;
        false ->
            case Value =< Num andalso Value rem 10 =:= K of
                true ->
                    case Num rem Value =:= 0 of
                        true -> Value;
                        false ->
                            find_sum(Num, K, Count + 1)
                    end;
                false ->
                    find_sum(Num, K, Count + 1)
            end
    end.
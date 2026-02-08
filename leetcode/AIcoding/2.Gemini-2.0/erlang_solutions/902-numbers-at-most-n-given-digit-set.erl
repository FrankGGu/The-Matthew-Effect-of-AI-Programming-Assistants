-module(numbers_at_most_n_given_digit_set).
-export([atMostNGivenDigitSet/2]).

atMostNGivenDigitSet(Digits, N) ->
    N_str = integer_to_list(N),
    N_len = length(N_str),
    D_len = length(Digits),
    Result = lists:foldl(fun(I, Acc) ->
        case I of
            1 ->
                Acc + (D_len - 1 rem D_len)
            _ ->
                Acc + (math:pow(D_len, I - 1))
        end
    end, 0, lists:seq(1, N_len - 1)),
    Result + Helper(Digits, N_str, 0).

Helper(Digits, N_str, Index) ->
    case Index of
        L when L == length(N_str) ->
            1;
        _ ->
            Digit = list_to_integer([lists:nth(Index + 1, N_str)]),
            Less = lists:foldl(fun(D, Acc) ->
                case list_to_integer([D]) < Digit of
                    true ->
                        Acc + 1;
                    _ ->
                        Acc
                end
            end, 0, Digits),
            Equal = lists:foldl(fun(D, Acc) ->
                case list_to_integer([D]) == Digit of
                    true ->
                        Acc + 1;
                    _ ->
                        Acc
                end
            end, 0, Digits),
            case Equal > 0 of
                true ->
                    case Index + 1 == length(N_str) of
                        true ->
                            Less + Equal;
                        false ->
                            Less * math:pow(length(Digits), length(N_str) - Index - 1) + Helper(Digits, N_str, Index + 1)
                    end;
                false ->
                    Less * math:pow(length(Digits), length(N_str) - Index - 1)
            end
    end.
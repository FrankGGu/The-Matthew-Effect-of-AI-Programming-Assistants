-module(reordered_power_of_2).
-export([reordered_power_of_2/1]).

reordered_power_of_2(N) ->
    Digits = lists:sort(integer_to_list(N)),
    check_powers(Digits, 0).

check_powers(Digits, Power) ->
    Pow2 = 1 bsl Power,
    Pow2Str = lists:sort(integer_to_list(Pow2)),
    case Pow2 > 1000000000 of
        true -> false;
        false ->
            case Digits == Pow2Str of
                true -> true;
                false -> check_powers(Digits, Power + 1)
            end
    end.
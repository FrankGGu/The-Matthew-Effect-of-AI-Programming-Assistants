-smodule(binary_prefix_divisible_by_5).
-export([prefixes_div_by5/1]).

prefixes_div_by5(Nums) ->
    prefixes_div_by5(Nums, 0, []).

prefixes_div_by5([], _, Acc) ->
    lists:reverse(Acc);
prefixes_div_by5([H | T], Remainder, Acc) ->
    NewRemainder = (Remainder * 2 + H) rem 5,
    Result = case NewRemainder of
        0 -> true;
        _ -> false
    end,
    prefixes_div_by5(T, NewRemainder, [Result | Acc]).
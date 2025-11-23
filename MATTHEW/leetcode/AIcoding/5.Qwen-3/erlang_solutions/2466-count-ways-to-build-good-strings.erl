-module(solution).
-export([countDifferentIntegers/2]).

countDifferentIntegers(Nums, Target) ->
    Count = 0,
    countDifferentIntegers(Nums, Target, Count).

countDifferentIntegers([], _, Count) ->
    Count;
countDifferentIntegers([Num | Rest], Target, Count) ->
    case isGoodString(Num, Target) of
        true -> countDifferentIntegers(Rest, Target, Count + 1);
        false -> countDifferentIntegers(Rest, Target, Count)
    end.

isGoodString(Num, Target) ->
    Len = length(Num),
    if
        Len > Target -> false;
        true -> checkDigits(Num, Target)
    end.

checkDigits([], _) ->
    true;
checkDigits([Digit | Rest], Target) ->
    case Digit of
        $0 -> checkDigits(Rest, Target);
        _ -> checkDigits(Rest, Target - 1)
    end.
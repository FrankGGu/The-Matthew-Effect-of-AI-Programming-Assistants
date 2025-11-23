-module(solution).
-export([min_integer/2]).

min_integer(S, K) ->
    Digits = string:to_list(S),
    MinDigits = min_integer_helper(Digits, K, length(Digits)),
    list_to_binary(MinDigits).

min_integer_helper(Digits, K, N) when K > 0, N > 0 ->
    {MinDigit, MinIndex} = find_min(Digits, 0, K),
    case MinIndex of
        Index when Index > 0 -> 
            NewDigits = swap(Digits, Index, 0),
            min_integer_helper(NewDigits, K - (Index - 0), N - 1);
        _ -> 
            Digits
    end;
min_integer_helper(Digits, _, _) -> Digits.

find_min(Digits, Start, K) ->
    MinDigit = hd(Digits),
    MinIndex = Start,
    lists:foldl(fun(D, {CurrentMin, Index, K}) ->
        case {Index - Start, K} of
            {Idx, _} when Idx > K -> {CurrentMin, Index, K};
            {_, _} when D < CurrentMin -> {D, Index, K};
            _ -> {CurrentMin, Index, K}
        end
    end, {MinDigit, Start, K}, tl(Digits)).

swap(Digits, I, J) ->
    List = lists:map(fun(X, Index) -> 
        case Index of
            I -> lists:nth(J + 1, Digits);
            J -> lists:nth(I + 1, Digits);
            _ -> X
        end
    end, Digits, lists:seq(0, length(Digits) - 1)),
    List.
-module(longest_binary_subsequence_less_than_or_equal_k).
-export([longest_binary_subsequence/2]).

longest_binary_subsequence(BinStr, K) ->
    N = length(BinStr),
    MaxLen = 0,
    lists:foldl(fun(I, Acc) ->
        case I of
            0 -> Acc;
            _ ->
                Sub = string:substr(BinStr, I),
                if
                    binary_to_integer(Sub, 2) =< K -> max(Acc, length(Sub));
                    true -> Acc
                end
        end
    end, MaxLen, lists:seq(1, N)).

binary_to_integer(BinStr, Base) ->
    binary_to_integer(BinStr, Base, 0).

binary_to_integer([], _, Acc) ->
    Acc;
binary_to_integer([C | Rest], Base, Acc) ->
    Digit = C - $0,
    binary_to_integer(Rest, Base, Acc * Base + Digit).
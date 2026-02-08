-module(solution).
-export([smallestNumber/1]).

smallestNumber(N) when N < 0 ->
    -1 * smallest_positive(-N);
smallestNumber(N) ->
    smallest_positive(N).

smallest_positive(N) ->
    Digits = integer_to_list(N),
    SortedDigits = lists:sort(Digits),
    Trimmed = trim_leading_zero(SortedDigits),
    case Trimmed of
        [] -> "0";
        [H | T] -> [H | [hd(T)] | tl(T)] ++ [H]
    end.

trim_leading_zero(Digits) ->
    case lists:prefix(Digits, [$_0]) of
        true -> lists:drop_while(fun(X) -> X =:= $0 end, Digits);
        false -> Digits
    end.
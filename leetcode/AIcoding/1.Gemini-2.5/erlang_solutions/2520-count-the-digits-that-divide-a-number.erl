-module(solution).
-export([countDigits/1]).

countDigits(Num) ->
    countDigits_recursive(Num, Num, 0).

countDigits_recursive(0, _OriginalNum, Count) ->
    Count;
countDigits_recursive(CurrentNum, OriginalNum, Count) ->
    Digit = CurrentNum rem 10,
    NewCount = if
        Digit =/= 0 andalso OriginalNum rem Digit == 0 ->
            Count + 1;
        true ->
            Count
    end,
    countDigits_recursive(CurrentNum div 10, OriginalNum, NewCount).
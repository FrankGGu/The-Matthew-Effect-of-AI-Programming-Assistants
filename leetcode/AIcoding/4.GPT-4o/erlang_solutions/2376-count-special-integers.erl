-module(solution).
-export([count_special_integers/1]).

count_special_integers(N) ->
    count_special_integers_helper(N, 0, 0).

count_special_integers_helper(N, Count, Digits) ->
    NewCount = Count + count_no_repeat_integers(N, Digits),
    if
        N < 10 -> NewCount + N;
        true -> count_special_integers_helper(N div 10, NewCount, Digits + 1)
    end.

count_no_repeat_integers(N, Digits) ->
    case Digits of
        0 -> 0;
        1 -> N;
        _ ->
            Base = 9,
            Count = 1,
            case Digits - 1 of
                D when D > 0 ->
                    lists:foldl(fun(_, Acc) -> Acc * Base end, 1, lists:seq(1, D)) * 9;
                _ -> 0
            end
    end.
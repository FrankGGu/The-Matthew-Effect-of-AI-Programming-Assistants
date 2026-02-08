-module(reconstruct_original_digits_from_english).
-export([original_digits/1]).

original_digits(S) ->
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc) end, #{}, S),
    Digits = lists:seq(0,9),
    Result = lists:foldl(fun(Digit, Acc) -> 
        case Digit of
            0 -> count_zero(Count, Acc);
            1 -> count_one(Count, Acc);
            2 -> count_two(Count, Acc);
            3 -> count_three(Count, Acc);
            4 -> count_four(Count, Acc);
            5 -> count_five(Count, Acc);
            6 -> count_six(Count, Acc);
            7 -> count_seven(Count, Acc);
            8 -> count_eight(Count, Acc);
            9 -> count_nine(Count, Acc)
        end
    end, [], Digits),
    lists:sort(Result).

count_zero(Count, Acc) ->
    Num = maps:get($z, Count, 0),
    lists:duplicate(Num, 0) ++ Acc.

count_one(Count, Acc) ->
    Num = maps:get($o, Count, 0) - maps:get($z, Count, 0) - maps:get($w, Count, 0) - maps:get($u, Count, 0),
    lists:duplicate(Num, 1) ++ Acc.

count_two(Count, Acc) ->
    Num = maps:get($w, Count, 0),
    lists:duplicate(Num, 2) ++ Acc.

count_three(Count, Acc) ->
    Num = maps:get($h, Count, 0) - maps:get($s, Count, 0) - maps:get($x, Count, 0),
    lists:duplicate(Num, 3) ++ Acc.

count_four(Count, Acc) ->
    Num = maps:get($u, Count, 0),
    lists:duplicate(Num, 4) ++ Acc.

count_five(Count, Acc) ->
    Num = maps:get($f, Count, 0) - maps:get($u, Count, 0),
    lists:duplicate(Num, 5) ++ Acc.

count_six(Count, Acc) ->
    Num = maps:get($x, Count, 0),
    lists:duplicate(Num, 6) ++ Acc.

count_seven(Count, Acc) ->
    Num = maps:get($s, Count, 0) - maps:get($x, Count, 0),
    lists:duplicate(Num, 7) ++ Acc.

count_eight(Count, Acc) ->
    Num = maps:get($g, Count, 0),
    lists:duplicate(Num, 8) ++ Acc.

count_nine(Count, Acc) ->
    Num = maps:get($i, Count, 0) - maps:get($f, Count, 0) - maps:get($s, Count, 0) - maps:get($x, Count, 0) - maps:get($g, Count, 0),
    lists:duplicate(Num, 9) ++ Acc.
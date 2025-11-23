-module(solution).
-export([sequential_digits/2]).

sequential_digits(Min, Max) ->
    Lists = lists:map(fun(X) -> lists:seq(X, 9) end, [1,2,3,4,5,6,7,8]),
    SequentialDigits = lists:flatmap(fun(Seq) -> generate_digits(Seq, Min, Max) end, Lists),
    lists:sort(SequentialDigits).

generate_digits(Seq, Min, Max) ->
    DigitString = lists:map(fun(X) -> integer_to_list(X) end, Seq),
    DigitNum = list_to_integer(lists:foldl(fun(X, Acc) -> Acc ++ X end, [], DigitString)),
    if 
        DigitNum >= Min andalso DigitNum =< Max -> [DigitNum];
        true -> []
    end.
-module(solution).
-export([find_even_numbers/1]).

find_even_numbers(Digits) ->
    DigitsList = lists:filter(fun(X) -> X rem 2 =:= 0 end, Digits),
    EvenNumbers = lists:foldl(fun(D, Acc) -> 
        [H || H <- lists:seq(100, 999), 
        lists:all(fun(X) -> lists:member(X, Digits) end, digits(H)),
        H rem 2 =:= 0] ++ Acc 
    end, [], DigitsList),
    lists:usort(EvenNumbers).

digits(N) ->
    case N of
        0 -> [0];
        _ -> digits(N div 10) ++ [N rem 10]
    end.
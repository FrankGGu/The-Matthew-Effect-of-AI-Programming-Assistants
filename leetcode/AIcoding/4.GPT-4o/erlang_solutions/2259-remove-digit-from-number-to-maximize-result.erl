-module(solution).
-export([remove_digit/2]).

remove_digit(NumberString, Digit) ->
    MaxResult = lists:foldl(fun(Char, Acc) ->
        case Char =:= $0 + list_to_integer(Digit) of
            true -> 
                NewNumber = lists:sublist(NumberString, 1, lists:find_index(fun(X) -> X =:= Char end, NumberString)) ++ 
                             lists:sublist(NumberString, lists:find_index(fun(X) -> X =:= Char end, NumberString) + 2, length(NumberString)),
                Max = lists:max([list_to_integer(Acc), list_to_integer(NewNumber)]),
                integer_to_list(Max);
            false -> Acc
        end
    end, "0", NumberString),
    case MaxResult of
        "0" -> "0";
        _ -> MaxResult
    end.
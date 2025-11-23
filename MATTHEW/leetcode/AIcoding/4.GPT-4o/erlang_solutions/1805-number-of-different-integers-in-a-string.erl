-module(solution).
-export([num_different_integers/1]).

num_different_integers(S) ->
    StringChars = string:to_list(S),
    Digits = lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, StringChars),
    Integers = lists:foldl(fun(Char, Acc) -> 
        case Acc of
            [] -> [[Char]];
            [[H | _] | T] when H =:= $0 -> [[Char | H] | T];
            [H | T] when Char =:= $0 -> [H | T];
            [H | T] -> if H =:= $0 -> [H | T]; true -> [[Char] | Acc] end
        end
    end, [], lists:map(fun(C) -> C - $0 end, Digits)),
    UniqueIntegers = lists:usort(lists:map(fun(List) -> list_to_integer(List) end, Integers)),
    length(UniqueIntegers).
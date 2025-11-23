-module(solution).
-export([largest_multiple_of_three/1]).

largest_multiple_of_three(Digits) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Digits),
    Sum = lists:sum(Sorted),
    case Sum rem 3 of
        0 -> 
            case Sorted of
                [] -> "0";
                [0|_] -> "0";
                _ -> lists:concat(lists:map(fun integer_to_list/1, Sorted))
            end;
        1 -> 
            case remove_remainder(Sorted, 1) of
                [] -> "";
                Res -> lists:concat(lists:map(fun integer_to_list/1, Res))
            end;
        2 -> 
            case remove_remainder(Sorted, 2) of
                [] -> "";
                Res -> lists:concat(lists:map(fun integer_to_list/1, Res))
            end
    end.

remove_remainder(Digits, Remainder) ->
    case find_and_remove(Digits, Remainder) of
        {ok, Res} -> Res;
        error -> 
            case find_and_remove_two(Digits, 3 - Remainder) of
                {ok, Res} -> Res;
                error -> []
            end
    end.

find_and_remove([], _) -> error;
find_and_remove([H|T], R) when H rem 3 == R -> {ok, T};
find_and_remove([H|T], R) ->
    case find_and_remove(T, R) of
        {ok, Rest} -> {ok, [H|Rest]};
        error -> error
    end.

find_and_remove_two(Digits, R) ->
    case find_and_remove(Digits, R) of
        {ok, Rest} -> 
            case find_and_remove(Rest, R) of
                {ok, Final} -> {ok, Final};
                error -> error
            end;
        error -> error
    end.
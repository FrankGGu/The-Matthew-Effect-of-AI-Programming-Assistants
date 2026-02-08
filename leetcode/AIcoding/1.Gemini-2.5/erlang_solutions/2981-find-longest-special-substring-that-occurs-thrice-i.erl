-module(solution).
-export([longest_special_substring/1]).

longest_special_substring(S) ->
    N = string:len(S),
    find_longest(N, S).

find_longest(N, S) ->
    lists:foldl(fun(L, Acc) ->
        case Acc of
            -1 -> 
                check_chars_for_length_and_return_L_if_found(L, S);
            _ -> Acc
        end
    end, -1, lists:seq(N - 2, 1, -1)).

check_chars_for_length_and_return_L_if_found(L, S) ->
    Chars = lists:seq($a, $z),
    Found = lists:any(fun(Char) ->
        SpecialSub = string:chars(Char, L),
        string:str_count(S, SpecialSub) >= 3
    end, Chars),
    if Found -> L;
       true -> -1
    end.
-module(solution).
-export([number_of_substrings/1]).

number_of_substrings(S) ->
    count_substrings(S, 0, 0, 0, 0).

count_substrings(S, L, R, C, Count) ->
    case lists:splitwith(fun(X) -> X =:= $a orelse X =:= $b orelse X =:= $c end, S) of
        {[], _} -> Count;
        {Chars, Rest} ->
            NewCount = if
                L > 0, R > 0, C > 0 -> Count + 1;
                true -> Count
            end,
            case Rest of
                [] -> NewCount;
                [H|T] -> 
                    case H of
                        $a -> count_substrings(T, L + 1, R, C, NewCount);
                        $b -> count_substrings(T, L, R + 1, C, NewCount);
                        $c -> count_substrings(T, L, R, C + 1, NewCount)
                    end
            end
    end.
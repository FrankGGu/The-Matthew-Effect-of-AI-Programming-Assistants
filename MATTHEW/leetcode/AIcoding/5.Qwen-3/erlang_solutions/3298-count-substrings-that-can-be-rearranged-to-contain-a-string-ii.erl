-module(solution).
-export([count_valid_substrings/1]).

count_valid_substrings(S) ->
    N = length(S),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if J - I + 1 > 50 -> Acc2;
               true ->
                    Sub = string:substr(S, I, J - I + 1),
                    Sorted = lists:sort(Sub),
                    case is_rearrangeable(Sorted) of
                        true -> Acc2 + 1;
                        false -> Acc2
                    end
            end
        end, Acc, lists:seq(I+1, N))
    end, Count, lists:seq(1, N)).

is_rearrangeable(Sorted) ->
    lists:all(fun(C) -> C >= $a andalso C =< $z end, Sorted).
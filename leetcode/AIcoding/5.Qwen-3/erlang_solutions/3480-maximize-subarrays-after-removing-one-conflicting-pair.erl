-module(solution).
-export([max_subarrays/1]).

max_subarrays(Numbers) ->
    N = length(Numbers),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if
                I < J andalso Numbers!!I > Numbers!!J ->
                    Count = count_subarrays(Numbers, I, J),
                    max(Acc2, Count);
                true ->
                    Acc2
            end
        end, Acc, lists:seq(I+1, N-1))
    end, Max, lists:seq(0, N-1)).

count_subarrays(Numbers, I, J) ->
    A = lists:sublist(Numbers, I),
    B = lists:sublist(Numbers, J+1, length(Numbers) - J - 1),
    C = A ++ B,
    count(C).

count([]) -> 0;
count([_]) -> 1;
count(List) ->
    count(List, 0, 1).

count([], Acc, _) -> Acc;
count([H|T], Acc, Prev) ->
    if H >= Prev -> count(T, Acc + 1, H);
       true -> count(T, Acc, H)
    end.
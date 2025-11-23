-module(solution).
-export([max_height/1]).

max_height(Cuboids) ->
    Sorted = lists:map(fun(C) -> lists:sort(fun(A, B) -> A >= B end, C) end, Cuboids),
    SortedCuboids = lists:sort(fun(A, B) -> 
        case lists:nth(1, A) =:= lists:nth(1, B) of
            true -> 
                case lists:nth(2, A) =:= lists:nth(2, B) of
                    true -> lists:nth(3, A) >= lists:nth(3, B);
                    false -> lists:nth(2, A) >= lists:nth(2, B)
                end;
            false -> lists:nth(1, A) >= lists:nth(1, B)
        end
    end, Sorted),
    DP = lists:map(fun(C) -> lists:nth(3, C) end, SortedCuboids),
    MaxHeight = lists:max(helper(SortedCuboids, DP, 1, length(SortedCuboids))),
    MaxHeight.

helper(_, DP, I, N) when I > N -> DP;
helper(Cuboids, DP, I, N) ->
    Current = lists:nth(I, Cuboids),
    NewDP = lists:map(fun({J, D}) ->
        Prev = lists:nth(J, Cuboids),
        case (lists:nth(1, Prev) >= lists:nth(1, Current) andalso
             (lists:nth(2, Prev) >= lists:nth(2, Current) andalso
             (lists:nth(3, Prev) >= lists:nth(3, Current)) of
            true -> max(D, lists:nth(J, DP) + lists:nth(3, Current));
            false -> D
        end
    end, lists:zip(lists:seq(1, I-1), lists:sublist(DP, I-1))),
    NewDPList = case NewDP of
        [] -> DP;
        _ -> lists:sublist(DP, I-1) ++ [lists:max([lists:nth(I, DP) | NewDP])] ++ lists:nthtail(I, DP)
    end,
    helper(Cuboids, NewDPList, I+1, N).
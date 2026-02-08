-spec maximum_sum(Nums :: [integer()]) -> integer().
maximum_sum(Nums) ->
    SumMap = lists:foldl(fun(Num, Acc) ->
        Sum = digit_sum(Num),
        case maps:get(Sum, Acc, none) of
            none -> maps:put(Sum, [Num], Acc);
            List -> maps:put(Sum, [Num | List], Acc)
        end
    end, #{}, Nums),
    case lists:filter(fun({_, L}) -> length(L) >= 2 end, maps:to_list(SumMap)) of
        [] -> -1;
        Pairs ->
            MaxSums = lists:map(fun({_, List}) ->
                Sorted = lists:sort(fun(A, B) -> B =< A end, List),
                lists:nth(1, Sorted) + lists:nth(2, Sorted)
            end, Pairs),
            lists:max(MaxSums)
    end.

digit_sum(N) ->
    digit_sum(abs(N), 0).

digit_sum(0, Sum) -> Sum;
digit_sum(N, Sum) ->
    digit_sum(N div 10, Sum + (N rem 10)).
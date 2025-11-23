-spec maximum_value_sum(Nums :: [integer()], K :: integer(), Edges :: [[integer()]]) -> integer().
maximum_value_sum(Nums, K, _Edges) ->
    Sum = lists:sum(Nums),
    Diffs = lists:map(fun(X) -> (X bxor K) - X end, Nums),
    PositiveDiffs = lists:filter(fun(X) -> X > 0 end, Diffs),
    SortedPositive = lists:sort(fun(A, B) -> A > B end, PositiveDiffs),
    case length(SortedPositive) rem 2 of
        0 -> Sum + lists:sum(SortedPositive);
        1 -> 
            case length(SortedPositive) > 1 of
                true -> 
                    Last = lists:last(SortedPositive),
                    Sum + lists:sum(lists:sublist(SortedPositive, length(SortedPositive) - 1)) - Last;
                false -> Sum
            end
    end.
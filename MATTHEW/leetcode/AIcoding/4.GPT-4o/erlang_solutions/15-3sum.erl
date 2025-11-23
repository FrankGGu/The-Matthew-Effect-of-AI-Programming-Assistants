-spec three_sum(Nums :: [integer()]) -> [[integer()]].
three_sum(Nums) ->
    SortedNums = lists:sort(Nums),
    three_sum(SortedNums, []).

three_sum([], Acc) -> Acc;
three_sum([H | T], Acc) ->
    two_sum(T, -H, [], Acc, H).

two_sum([], _, Acc, _, _) -> Acc;
two_sum([H | T], Target, Acc, Prev, _) when H == Prev -> two_sum(T, Target, Acc, H, Prev);
two_sum([H | T], Target, Acc, Prev, First) when H > Target -> two_sum(T, Target, Acc, H, Prev);
two_sum([H | T], Target, Acc, Prev, First) ->
    case lists:member(Target - H, T) of
        true -> two_sum(T, Target, [[First, H, Target - H] | Acc], H, First);
        false -> two_sum(T, Target, Acc, H, First)
    end.

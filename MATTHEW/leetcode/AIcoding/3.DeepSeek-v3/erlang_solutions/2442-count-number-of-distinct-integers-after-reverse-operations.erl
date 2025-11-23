-spec count_distinct_integers(Nums :: [integer()]) -> integer().
count_distinct_integers(Nums) ->
    Reversed = lists:map(fun reverse_num/1, Nums),
    AllNums = Nums ++ Reversed,
    length(sets:to_list(sets:from_list(AllNums))).

reverse_num(Num) ->
    reverse_num(Num, 0).

reverse_num(0, Acc) -> Acc;
reverse_num(Num, Acc) ->
    reverse_num(Num div 10, Acc * 10 + Num rem 10).
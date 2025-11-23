-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_subarrays(Nums, K) ->
    Index = find_index(Nums, K, 0),
    Counts = #{0 => 1},
    {Left, _} = count_balance(Nums, K, Index - 1, -1, 0, Counts, 0),
    {Right, _} = count_balance(Nums, K, Index + 1, 1, 0, #{0 => 1}, 0),
    Left + Right + Left * Right + 1.

find_index([K | _], K, Index) -> Index;
find_index([_ | Rest], K, Index) -> find_index(Rest, K, Index + 1).

count_balance(_, _, Index, _, _, Counts, Total) when Index < 0 -> {Total, Counts};
count_balance(Nums, K, Index, Dir, Balance, Counts, Total) when Index >= length(Nums) -> {Total, Counts};
count_balance(Nums, K, Index, Dir, Balance, Counts, Total) ->
    Num = lists:nth(Index + 1, Nums),
    NewBalance = if
        Num > K -> Balance + 1;
        true -> Balance - 1
    end,
    NewTotal = Total + maps:get(NewBalance, Counts, 0) + maps:get(NewBalance + 1, Counts, 0),
    NewCounts = maps:update_with(NewBalance, fun(V) -> V + 1 end, 1, Counts),
    count_balance(Nums, K, Index + Dir, Dir, NewBalance, NewCounts, NewTotal).
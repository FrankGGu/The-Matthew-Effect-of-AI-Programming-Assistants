-spec longest_consecutive(Nums :: [integer()]) -> integer().
longest_consecutive(Nums) ->
    Nums
    |> lists:usort()
    |> longest_consecutive_helper(0, 1, 0).

longest_consecutive_helper([], _, Max) -> Max;
longest_consecutive_helper([_], _, Max) -> Max;
longest_consecutive_helper([H1, H2 | T], Count, Max) when H2 =:= H1 + 1 ->
    longest_consecutive_helper([H2 | T], Count + 1, Max);
longest_consecutive_helper([_ | T], Count, Max) ->
    longest_consecutive_helper(T, 1, max(Count, Max)).

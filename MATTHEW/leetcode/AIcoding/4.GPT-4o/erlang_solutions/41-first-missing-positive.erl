-spec first_missing_positive(Nums :: [integer()]) -> integer().
first_missing_positive(Nums) ->
    first_missing_positive(Nums, length(Nums)).

first_missing_positive(Nums, N) ->
    first_missing_positive_helper(Nums, N, 1).

first_missing_positive_helper([], _, Missing) -> Missing;
first_missing_positive_helper([H | T], N, Missing) when H == Missing ->
    first_missing_positive_helper(T, N, Missing + 1);
first_missing_positive_helper([_ | T], N, Missing) ->
    first_missing_positive_helper(T, N, Missing).

-spec count_distinct(Nums :: [integer()], K :: integer(), P :: integer()) -> integer().
count_distinct(Nums, K, P) ->
    Subarrays = subarrays(Nums),
    lists:foldl(
        fun(Subarray, Acc) ->
            case length([X || X <- Subarray, X rem P =:= 0]) =< K of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        lists:usort(Subarrays)
    ).

subarrays([]) -> [];
subarrays([H|T]) ->
    subarrays(T) ++ lists:map(fun(X) -> [H|X] end, subarrays(T)) ++ [[H]].
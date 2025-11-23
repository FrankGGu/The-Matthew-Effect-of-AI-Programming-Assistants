-spec median_of_uniqueness_array(Nums :: [integer()]) -> float().
median_of_uniqueness_array(Nums) ->
    Subarrays = generate_subarrays(Nums),
    Uniqueness = lists:map(fun(Sub) -> length(lists:usort(Sub)) end, Subarrays),
    Sorted = lists:sort(Uniqueness),
    Len = length(Sorted),
    if
        Len rem 2 == 1 -> lists:nth(Len div 2 + 1, Sorted);
        true -> (lists:nth(Len div 2, Sorted) + lists:nth(Len div 2 + 1, Sorted)) / 2
    end.

generate_subarrays(Nums) ->
    generate_subarrays(Nums, 0, []).

generate_subarrays([], _Start, Acc) ->
    Acc;
generate_subarrays(Nums, Start, Acc) ->
    case generate_subarrays_from_start(Nums, Start, [], []) of
        {NewSubarrays, NewStart} ->
            generate_subarrays(Nums, NewStart, NewSubarrays ++ Acc)
    end.

generate_subarrays_from_start([], _Start, _Current, Subarrays) ->
    {Subarrays, 0};
generate_subarrays_from_start([H | T], Start, Current, Subarrays) ->
    NewCurrent = Current ++ [H],
    NewSubarrays = [NewCurrent | Subarrays],
    generate_subarrays_from_start(T, Start + 1, NewCurrent, NewSubarrays).
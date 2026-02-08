-spec num_of_subarrays(Nums :: [integer()], Pattern :: [integer()]) -> integer().
num_of_subarrays(Nums, Pattern) ->
    LenNums = length(Nums),
    LenPattern = length(Pattern),
    if
        LenNums < LenPattern + 1 -> 0;
        true ->
            Count = 0,
            num_of_subarrays(Nums, Pattern, LenNums, LenPattern, 0, Count)
    end.

num_of_subarrays(Nums, Pattern, LenNums, LenPattern, I, Count) when I =< LenNums - LenPattern ->
    Subarray = lists:sublist(Nums, I + 1, LenPattern + 1),
    Match = check_pattern(Subarray, Pattern, 0),
    NewCount = if Match -> Count + 1; true -> Count end,
    num_of_subarrays(Nums, Pattern, LenNums, LenPattern, I + 1, NewCount);
num_of_subarrays(_, _, _, _, _, Count) ->
    Count.

check_pattern([_], [], _) -> true;
check_pattern([A, B | Rest], [P | PRest], _) ->
    case P of
        1 -> (B > A) andalso check_pattern([B | Rest], PRest, 0);
        0 -> (B =:= A) andalso check_pattern([B | Rest], PRest, 0);
        -1 -> (B < A) andalso check_pattern([B | Rest], PRest, 0)
    end;
check_pattern(_, _, _) -> false.
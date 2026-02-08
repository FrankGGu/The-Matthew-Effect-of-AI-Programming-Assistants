-spec contains_pattern(Arr :: [integer()], M :: integer(), K :: integer()) -> boolean().
contains_pattern(Arr, M, K) ->
    N = length(Arr),
    if
        M * K > N -> false;
        true ->
            contains_pattern(Arr, M, K, 0, N - M * K)
    end.

contains_pattern(_, _, _, I, MaxI) when I > MaxI -> false;
contains_pattern(Arr, M, K, I, MaxI) ->
    Pattern = lists:sublist(Arr, I + 1, M),
    case check_pattern(Arr, Pattern, I + M, K - 1) of
        true -> true;
        false -> contains_pattern(Arr, M, K, I + 1, MaxI)
    end.

check_pattern(_, _, _, 0) -> true;
check_pattern(Arr, Pattern, Start, Count) ->
    case lists:sublist(Arr, Start + 1, length(Pattern)) of
        Pattern -> check_pattern(Arr, Pattern, Start + length(Pattern), Count - 1);
        _ -> false
    end.
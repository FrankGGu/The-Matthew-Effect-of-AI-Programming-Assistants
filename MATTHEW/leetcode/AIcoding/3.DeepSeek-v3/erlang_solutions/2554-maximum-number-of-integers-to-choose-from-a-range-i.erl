-spec max_count(Banned :: [integer()], N :: integer(), MaxSum :: integer()) -> integer().
max_count(Banned, N, MaxSum) ->
    BannedSet = sets:from_list(Banned),
    Sum = 0,
    Count = 0,
    max_count_helper(1, N, MaxSum, BannedSet, Sum, Count).

max_count_helper(Current, N, MaxSum, BannedSet, Sum, Count) when Current =< N ->
    case sets:is_element(Current, BannedSet) of
        true ->
            max_count_helper(Current + 1, N, MaxSum, BannedSet, Sum, Count);
        false ->
            NewSum = Sum + Current,
            if
                NewSum =< MaxSum ->
                    max_count_helper(Current + 1, N, MaxSum, BannedSet, NewSum, Count + 1);
                true ->
                    Count
            end
    end;
max_count_helper(_, _, _, _, _, Count) ->
    Count.
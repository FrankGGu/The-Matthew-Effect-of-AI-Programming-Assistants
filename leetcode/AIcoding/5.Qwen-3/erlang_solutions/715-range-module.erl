-module(range_module).
-export([new/0, add_range/2, query_ranges/1, remove_range/2]).

new() ->
    [].

add_range(Ranges, {L, R}) ->
    Add = [{L, R}],
    merge_ranges(Ranges, Add).

query_ranges(Ranges) ->
    Ranges.

remove_range(Ranges, {L, R}) ->
    Remove = [{L, R}],
    subtract_ranges(Ranges, Remove).

merge_ranges([], []) ->
    [];
merge_ranges([], Add) ->
    Add;
merge_ranges(Add, []) ->
    Add;
merge_ranges(Add, Ranges) ->
    Sorted = lists:sort(Add ++ Ranges),
    merge(Sorted, []).

merge([], Acc) ->
    lists:reverse(Acc);
merge([H | T], []) ->
    merge(T, [H]);
merge([H | T], [A | _] = Acc) ->
    case is_overlap(H, A) of
        true ->
            New = merge_overlapping(H, A),
            merge(T, [New | tl(Acc)]);
        false ->
            merge(T, [H | Acc])
    end.

is_overlap({L1, R1}, {L2, R2}) ->
    L1 < R2 andalso L2 < R1.

merge_overlapping({L1, R1}, {L2, R2}) ->
    {min(L1, L2), max(R1, R2)}.

subtract_ranges([], _) ->
    [];
subtract_ranges([H | T], Remove) ->
    Subtracted = subtract_range(H, Remove),
    Subtracted ++ subtract_ranges(T, Remove).

subtract_range({L, R}, []) ->
    [{L, R}];
subtract_range({L, R}, Remove) ->
    lists:foldl(fun({RL, RR}, Acc) ->
                    case RL >= R orelse RR <= L of
                        true ->
                            Acc;
                        false ->
                            Left = if RL > L -> [{L, RL}]; true -> [] end,
                            Right = if RR < R -> [{RR, R}]; true -> [] end,
                            Left ++ Right ++ Acc
                    end
                end, [], Remove).
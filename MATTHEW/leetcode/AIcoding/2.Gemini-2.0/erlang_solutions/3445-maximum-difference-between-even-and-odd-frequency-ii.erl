-module(maximum_difference_ii).
-export([maximum_difference/1]).

maximum_difference(Nums) ->
    maximum_difference(Nums, [], 0).

maximum_difference([], _, MaxDiff) ->
    MaxDiff;
maximum_difference([Num | Rest], Seen, MaxDiff) ->
    {Even, Odd} = count_occurrences(Num, Seen),
    NewSeen = update_seen(Num, Seen),
    Diff1 = MaxDiff,
    Diff2 = MaxDiff,

    if Even > 0 orelse Odd > 0 then
        Diff1 = maximum(MaxDiff, Num + calculate_max_diff(NewSeen)),
        Diff2 = maximum(MaxDiff, -Num + calculate_max_diff(NewSeen))
    end,
    maximum_difference(Rest, NewSeen, maximum(Diff1, Diff2)).

count_occurrences(Num, Seen) ->
    case lists:keyfind(Num, 1, Seen) of
        false ->
            {0, 0};
        {_, Count} ->
            if Count rem 2 == 0 then
                {Count div 2, (Count + 1) div 2}
            else
                {(Count + 1) div 2, Count div 2}
            end
    end.

update_seen(Num, Seen) ->
    case lists:keyfind(Num, 1, Seen) of
        false ->
            [{Num, 1} | Seen];
        {Num, Count} ->
            lists:keyreplace(Num, 1, Seen, {Num, Count + 1})
    end.

calculate_max_diff(Seen) ->
    lists:foldl(fun({Num, Count}, Acc) ->
                        if Count rem 2 == 0 then
                            Acc - Num
                        else
                            Acc + Num
                        end
                end, 0, Seen).

maximum(A, B) ->
    if A > B then
        A
    else
        B
    end.
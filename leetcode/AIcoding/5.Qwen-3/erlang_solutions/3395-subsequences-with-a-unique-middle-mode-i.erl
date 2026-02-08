-module(subsequences_with_unique_middle_mode_i).
-export([num_subseqs/1]).

num_subseqs(Nums) ->
    Count = maps:from_list([{N, 0} || N <- lists:usort(Nums)]),
    CountMap = count_occurrences(Nums, Count),
    Modes = find_modes(CountMap),
    case Modes of
        [] -> 0;
        _ -> calculate_ways(Modes, CountMap)
    end.

count_occurrences([], Acc) -> Acc;
count_occurrences([H | T], Acc) ->
    NewAcc = maps:update(H, maps:get(H, Acc) + 1, Acc),
    count_occurrences(T, NewAcc).

find_modes(CountMap) ->
    MaxFreq = lists:max(maps:values(CountMap)),
    [Key || {Key, Val} <- maps:to_list(CountMap), Val == MaxFreq].

calculate_ways([], _) -> 0;
calculate_ways([Mode | Rest], CountMap) ->
    Ways = lists:foldl(fun(Key, Acc) ->
                           if Key == Mode -> Acc;
                              true -> Acc * (maps:get(Key, CountMap) + 1)
                           end
                       end, 1, maps:keys(CountMap)),
    Ways + calculate_ways(Rest, CountMap).
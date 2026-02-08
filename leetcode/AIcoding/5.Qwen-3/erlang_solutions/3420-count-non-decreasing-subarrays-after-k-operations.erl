-module(solution).
-export([count_non_decreasing_subarrays/1]).

count_non_decreasing_subarrays(Nums) ->
    count_non_decreasing_subarrays(Nums, 0, 0, []).

count_non_decreasing_subarrays([], _, _, Acc) ->
    lists:sum(Acc);
count_non_decreasing_subarrays([H | T], Start, Length, Acc) ->
    case T of
        [] ->
            count_non_decreasing_subarrays([], Start, Length + 1, [Length + 1 | Acc]);
        _ ->
            if H =< hd(T) ->
                count_non_decreasing_subarrays(T, Start, Length + 1, Acc);
            true ->
                count_non_decreasing_subarrays(T, Start, 1, [Length + 1 | Acc])
            end
    end.
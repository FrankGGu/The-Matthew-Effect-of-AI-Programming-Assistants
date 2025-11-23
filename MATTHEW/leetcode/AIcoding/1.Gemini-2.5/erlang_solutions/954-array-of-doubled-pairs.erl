-module(solution).
-export([can_reorder_doubled/1]).

can_reorder_doubled(Arr) ->
    Counts = lists:foldl(
        fun(N, Acc) ->
            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
        end,
        #{},
        Arr
    ),
    UniqueNums = maps:keys(Counts),
    SortedNums = lists:sort(fun(A, B) -> abs(A) < abs(B) end, UniqueNums),
    check_pairs(SortedNums, Counts).

check_pairs([], _Counts) ->
    true;
check_pairs([N | Rest], Counts) ->
    case maps:get(N, Counts, 0) of
        0 ->
            check_pairs(Rest, Counts);
        N_Count ->
            if N == 0 ->
                if N_Count rem 2 == 0 ->
                    check_pairs(Rest, maps:put(0, 0, Counts));
                true ->
                    false
                end;
            true ->
                Target = 2 * N,
                case maps:get(Target, Counts, 0) of
                    Target_Count when Target_Count >= N_Count ->
                        NewCounts = maps:put(N, 0, maps:put(Target, Target_Count - N_Count, Counts)),
                        check_pairs(Rest, NewCounts);
                    _ ->
                        false
                end
            end
    end.
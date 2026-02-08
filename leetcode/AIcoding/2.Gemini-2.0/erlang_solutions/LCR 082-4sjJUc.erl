-module(combination_sum_ii).
-export([combination_sum2/2]).

combination_sum2(Candidates, Target) ->
    SortedCandidates = lists:sort(Candidates),
    find_combinations(SortedCandidates, Target, [], []).

find_combinations([], 0, Acc, _) ->
    [lists:reverse(Acc)];
find_combinations([], _, _, _) ->
    [];
find_combinations(_Candidates, Target, _Acc, _) when Target < 0 ->
    [];
find_combinations([H|T], Target, Acc, Used) ->
    Result1 = find_combinations(T, Target, Acc, [H|Used]),
    Result2 =
        case lists:member(H, Used) of
            true ->
                [];
            false ->
                find_combinations(T, Target - H, [H|Acc], [H|Used])
        end,
    lists:usort(Result1 ++ Result2).
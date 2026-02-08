-module(solution).
-export([recoverArray/1]).

recoverArray(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(Nums) div 2,
    FirstElem = hd(SortedNums),

    CandidateKValues = lists:filtermap(
        fun(X) ->
            Diff = X - FirstElem,
            if
                Diff > 0 andalso (Diff rem 2 == 0) -> {true, Diff div 2};
                true -> false
            end
        end,
        tl(SortedNums)
    ),

    UniqueCandidateKValues = lists:sort(lists:usort(CandidateKValues)),

    find_solution(UniqueCandidateKValues, SortedNums, N).

find_solution([K | RestK], SortedNums, N) ->
    case try_k(K, SortedNums, N) of
        {ok, Result} -> Result;
        {error, _} -> find_solution(RestK, SortedNums, N)
    end;
find_solution([], _, _) ->
    throw(no_solution_found).

try_k(K, SortedNums, N) ->
    FreqMap = lists:foldl(
        fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end,
        maps:new(),
        SortedNums
    ),
    recover_original_recursive(K, SortedNums, N, FreqMap, []).

recover_original_recursive(K, _, N, FreqMap, Acc) when length(Acc) == N ->
    {ok, lists:reverse(Acc)};
recover_original_recursive(K, [H|T], N, FreqMap, Acc) ->
    case maps:get(H, FreqMap, 0) of
        0 ->
            recover_original_recursive(K, T, N, FreqMap, Acc);
        _ ->
            Target = H + 2 * K,
            case maps:get(Target, FreqMap, 0) of
                0 ->
                    {error, invalid_k};
                _ ->
                    NewFreqMap1 = maps:update_with(H, fun(V) -> V - 1 end, FreqMap),
                    NewFreqMap2 = maps:update_with(Target, fun(V) -> V - 1 end, NewFreqMap1),
                    recover_original_recursive(K, T, N, NewFreqMap2, [H + K | Acc])
            end
    end;
recover_original_recursive(_, [], _, _, _) ->
    {error, not_enough_pairs}.
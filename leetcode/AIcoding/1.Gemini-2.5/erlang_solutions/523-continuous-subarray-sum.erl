-module(solution).
-export([checkSubarraySum/2]).

checkSubarraySum(Nums, K) ->
    checkSubarraySum_helper(Nums, K, 0, #{0 => -1}, 0).

checkSubarraySum_helper([], _K, _CurrentSum, _RemainderMap, _Index) ->
    false;
checkSubarraySum_helper([H|T], K, CurrentSum, RemainderMap, Index) ->
    NewCurrentSum = CurrentSum + H,
    Remainder = if
        K == 0 ->
            NewCurrentSum;
        true ->
            (NewCurrentSum rem K + K) rem K
    end,

    case maps:find(Remainder, RemainderMap) of
        {ok, PrevIndex} ->
            if
                Index - PrevIndex >= 2 ->
                    true;
                true ->
                    checkSubarraySum_helper(T, K, NewCurrentSum, RemainderMap, Index + 1)
            end;
        error ->
            NewRemainderMap = maps:put(Remainder, Index, RemainderMap),
            checkSubarraySum_helper(T, K, NewCurrentSum, NewRemainderMap, Index + 1)
    end.
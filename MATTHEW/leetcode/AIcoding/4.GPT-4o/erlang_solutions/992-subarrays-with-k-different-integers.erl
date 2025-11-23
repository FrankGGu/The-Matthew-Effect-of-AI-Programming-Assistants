-module(solution).
-export([subarrays_with_k_different_integers/2]).

subarrays_with_k_different_integers(A, K) ->
    count_subarrays(A, K) - count_subarrays(A, K - 1).

count_subarrays(_, 0) -> 0;
count_subarrays(A, K) ->
    Count = 0,
    Map = dict:new(),
    {L, R} = {0, 0},
    Length = length(A),
    loop(A, Length, L, R, K, Map, Count).

loop(A, Length, L, R, K, Map, Count) when R < Length ->
    case dict:size(Map) =:= K of
        true ->
            NewCount = Count + (Length - R),
            loop(A, Length, L, R, K, Map, NewCount);
        false ->
            case R < Length -> 
                NewMap = dict:update_counter(A[R], 1, Map),
                loop(A, Length, L, R + 1, K, NewMap, Count);
                true -> 
                    case L < R -> 
                        NewMap = dict:update_counter(A[L], -1, Map),
                        loop(A, Length, L + 1, R, K, NewMap, Count);
                        true -> 
                            Count
                    end
            end
    end;
loop(_, _, _, _, _, _, Count) -> Count.
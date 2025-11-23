-module(solution).
-export([containsDuplicateIII/3]).

containsDuplicateIII(Nums, K, T) ->
    W = T + 1,
    ListLen = length(Nums),
    contains_duplicate_iii_loop(Nums, K, T, W, 0, ListLen, #{}).

contains_duplicate_iii_loop(Nums, K, T, W, I, ListLen, Buckets) ->
    if
        I >= ListLen ->
            false;
        true ->
            Val = lists:nth(I + 1, Nums),
            BucketIdx = erlang:floor(Val / W),

            % Check current bucket
            case maps:find(BucketIdx, Buckets) of
                {ok, _StoredVal} ->
                    % If a value exists in the same bucket, their difference is < W = T+1, so <= T.
                    % This means abs(Val - StoredVal) <= T is always true.
                    true;
                _ ->
                    % Check adjacent buckets
                    FoundPrev = 
                        case maps:find(BucketIdx - 1, Buckets) of
                            {ok, PrevVal} ->
                                erlang:abs(Val - PrevVal) =< T;
                            _ ->
                                false
                        end,

                    FoundNext = 
                        case maps:find(BucketIdx + 1, Buckets) of
                            {ok, NextVal} ->
                                erlang:abs(Val - NextVal) =< T;
                            _ ->
                                false
                        end,

                    if FoundPrev orelse FoundNext ->
                        true;
                    true ->
                        % Add current value to buckets
                        NewBuckets = maps:put(BucketIdx, Val, Buckets),

                        % Remove oldest element if window size exceeded
                        UpdatedBuckets = 
                            if I >= K ->
                                OldVal = lists:nth(I - K + 1, Nums),
                                OldBucketIdx = erlang:floor(OldVal / W),
                                maps:remove(OldBucketIdx, NewBuckets);
                            true ->
                                NewBuckets
                            end,

                        contains_duplicate_iii_loop(Nums, K, T, W, I + 1, ListLen, UpdatedBuckets)
                    end
            end
    end.
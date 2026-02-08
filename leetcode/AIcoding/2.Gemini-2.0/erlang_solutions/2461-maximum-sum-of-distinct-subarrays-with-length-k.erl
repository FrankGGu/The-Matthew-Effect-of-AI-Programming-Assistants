-module(max_sum_distinct_subarrays).
-export([maximum_subarray_sum/2]).

maximum_subarray_sum(Nums, K) ->
    maximum_subarray_sum(Nums, K, 0, 0, 0, sets:new(), 0).

maximum_subarray_sum([], _, MaxSum, _, _, _, _) ->
    MaxSum;
maximum_subarray_sum(Nums, K, CurrentSum, CurrentLength, MaxSum, Seen, Index) ->
    case Nums of
        [H | T] ->
            case sets:is_element(H, Seen) of
                true ->
                    maximum_subarray_sum(T, K, 0, 0, MaxSum, sets:new(), Index + 1);
                false ->
                    NewSeen = sets:add_element(H, Seen),
                    NewCurrentSum = CurrentSum + H,
                    NewCurrentLength = CurrentLength + 1,
                    case NewCurrentLength == K of
                        true ->
                            NewMaxSum = max(MaxSum, NewCurrentSum),

                            ListToDrop = lists:sublist(Nums, Index + 1, K),

                            DroppedValue = hd(ListToDrop),

                            NewSeen2 = sets:del_element(DroppedValue, NewSeen),

                            NewCurrentSum2 = NewCurrentSum - DroppedValue,

                            maximum_subarray_sum(T, K, NewCurrentSum2, NewCurrentLength - 1, NewMaxSum, NewSeen2, Index + 1);
                        false ->
                            maximum_subarray_sum(T, K, NewCurrentSum, NewCurrentLength, MaxSum, NewSeen, Index + 1)
                    end
            end;
        [] ->
            MaxSum
    end.

max(A, B) ->
    if A > B ->
        A;
    true ->
        B
    end.
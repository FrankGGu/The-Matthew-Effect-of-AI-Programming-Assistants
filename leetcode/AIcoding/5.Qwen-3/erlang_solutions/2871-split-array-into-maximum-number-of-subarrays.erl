-module(solution).
-export([split_array_into_max_subarrays/1]).

split_array_into_max_subarrays(Arr) ->
    split_array_into_max_subarrays(Arr, 0, 0, 0).

split_array_into_max_subarrays([], _, _, Count) ->
    Count;
split_array_into_max_subarrays([H | T], Index, CurrentSum, Count) ->
    case H of
        0 ->
            split_array_into_max_subarrays(T, Index + 1, 0, Count + 1);
        _ ->
            NewSum = CurrentSum + H,
            if
                NewSum == 0 ->
                    split_array_into_max_subarrays(T, Index + 1, 0, Count + 1);
                true ->
                    split_array_into_max_subarrays(T, Index + 1, NewSum, Count)
            end
    end.
-module(solution).
-export([maximum_subarray_sum_with_one_deletion/1]).

maximum_subarray_sum_with_one_deletion(Arr) ->
    case Arr of
        [] -> 0;
        [H | T] ->
            % dp0: maximum subarray sum ending at the current position without any deletion.
            % dp1: maximum subarray sum ending at the current position with exactly one deletion.
            % ans: overall maximum subarray sum found so far.

            % Initialize dp0 with the first element.
            % Initialize dp1 to 0. This represents the case where the first element is deleted,
            % or an empty prefix before the first element, allowing a deletion to start a new sum.
            % Initialize ans with the first element, as a single element subarray is valid.
            {_Final_dp0, _Final_dp1, Final_ans} = lists:foldl(
                fun(Num, {Current_dp0, Current_dp1, Current_ans}) ->
                    % Calculate New_dp0:
                    % Either start a new subarray with Num, or extend the previous dp0.
                    New_dp0 = max(Num, Current_dp0 + Num),

                    % Calculate New_dp1:
                    % 1. Delete the current Num: The sum would be Current_dp0 (max sum ending at previous position without deletion).
                    % 2. An element was already deleted earlier: Extend Current_dp1 with Num.
                    New_dp1 = max(Current_dp0, Current_dp1 + Num),

                    % Update overall answer:
                    % It can be either a subarray without deletion (New_dp0)
                    % or a subarray with one deletion (New_dp1).
                    New_ans = max(Current_ans, max(New_dp0, New_dp1)),

                    {New_dp0, New_dp1, New_ans}
                end,
                {H, 0, H}, % Initial accumulator: {dp0, dp1, ans}
                T % Iterate over the rest of the list
            ),
            Final_ans
    end.

max(A, B) when A >= B -> A;
max(A, B) -> B.
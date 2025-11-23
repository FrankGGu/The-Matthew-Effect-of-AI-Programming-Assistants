-module(solution).
-export([count_non_decreasing_digits/1]).

count_non_decreasing_digits(N) ->
    S = integer_to_list(N), % Convert N to a list of characters (e.g., 123 -> "123")
    Len = length(S),

    % Initial call to the recursive solver.
    % Start at index 0, previous digit is effectively 0 (no restriction yet),
    % tight constraint is true (initially restricted by N),
    % not started (no non-zero digit placed yet).
    % Memo is an empty map initially.
    {Result, _FinalMemo} = solve(0, 0, true, false, S, Len, maps:new()),

    % The solve function counts numbers from 1 to N.
    % We need to add 1 for the number 0, which is a non-decreasing digit number.
    Result + 1.

solve(Idx, PrevDigit, IsTight, IsStarted, S, Len, Memo) ->
    Key = {Idx, PrevDigit, IsTight, IsStarted},
    case maps:find(Key, Memo) of
        {ok, Value} -> 
            % If already computed, return the value and the current memo map (unchanged).
            {Value, Memo};
        _ ->
            if Idx == Len ->
                % Base case: All digits have been placed.
                % If a non-zero digit was placed (IsStarted is true), this is a valid number (count 1).
                % If only leading zeros were placed (IsStarted is false), this corresponds to the number 0,
                % which is handled by adding 1 at the end of count_non_decreasing_digits. So count 0 here.
                Result = if IsStarted -> 1;
                         else -> 0
                         end,
                % Store and return the result with the updated memo.
                {Result, maps:put(Key, Result, Memo)};
            true ->
                % Determine the upper bound for the current digit.
                % If IsTight is true, the digit cannot exceed the corresponding digit in N.
                % Otherwise, it can be any digit up to 9.
                UpperBound = if IsTight -> (list_to_integer([lists:nth(Idx + 1, S)]) - 48); % lists:nth is 1-indexed, ASCII '0' is 48
                             else -> 9
                             end,

                % Iterate through possible digits for the current position.
                % solve_loop accumulates results and updates the memo.
                {Ans, UpdatedMemo} = solve_loop(0, UpperBound, Idx, PrevDigit, IsTight, IsStarted, S, Len, Memo, 0),

                % Store and return the total count for this state with the updated memo.
                {Ans, maps:put(Key, Ans, UpdatedMemo)}
            end
    end.

solve_loop(Digit, UpperBound, Idx, PrevDigit, IsTight, IsStarted, S, Len, Memo, Acc) when Digit =< UpperBound ->
    % Recursive call to solve for the next digit position.
    {NewAns, UpdatedMemo1} = 
        if IsStarted == false -> % We are currently placing leading zeros or the first non-zero digit.
            if Digit == 0 ->
                % Continue placing leading zeros. prev_digit remains 0.
                solve(Idx + 1, 0, IsTight andalso (Digit == UpperBound), false, S, Len, Memo);
            else ->
                % Placed the first non-zero digit. prev_digit becomes current Digit.
                % is_started becomes true.
                solve(Idx + 1, Digit, IsTight andalso (Digit == UpperBound), true, S, Len, Memo)
            end;
        true -> % IsStarted == true, we have already placed a non-zero digit.
            if Digit >= PrevDigit ->
                % Current digit must be greater than or equal to the previous digit.
                solve(Idx + 1, Digit, IsTight andalso (Digit == UpperBound), true, S, Len, Memo);
            else ->
                % If digit is decreasing, this path is invalid. Add 0 to count.
                % Memo is unchanged as no recursive call was made through this branch.
                {0, Memo} 
            end
        end,
    % Accumulate the results and continue the loop for the next possible digit.
    solve_loop(Digit + 1, UpperBound, Idx, PrevDigit, IsTight, IsStarted, S, Len, UpdatedMemo1, Acc + NewAns);
solve_loop(_Digit, _UpperBound, _Idx, _PrevDigit, _IsTight, _IsStarted, _S, _Len, Memo, Acc) ->
    % Base case for the loop: All digits from 0 to UpperBound have been tried.
    % Return the accumulated count and the final memo map from this loop.
    {Acc, Memo}.
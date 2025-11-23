-module(solution).
-export([next_greater_element/1]).

next_greater_element(N) ->
    MaxInt = 2147483647,
    Digits = int_to_digits(N),
    Len = length(Digits),

    % Step 1: Find the largest index k such that Digits[k] < Digits[k+1] (0-indexed)
    % Iterate from right to left (Len-2 down to 0)
    K = find_k_idx(Digits, Len - 2),

    case K of
        undefined -> % No such k, digits are in descending order (e.g., 321)
            -1;
        _ ->
            % Step 2: Find the largest index l > k such that Digits[k] < Digits[l] (0-indexed)
            Dk = lists:nth(K + 1, Digits), % lists:nth is 1-indexed
            L = find_l_idx(Digits, K, Dk, Len - 1),

            % Step 3: Swap Digits[k] and Digits[l]
            SwappedDigits = swap_elements(Digits, K, L),

            % Step 4: Reverse the sub-array from Digits[k+1] to the end
            Prefix = lists:sublist(SwappedDigits, 1, K + 1),
            Suffix = lists:sublist(SwappedDigits, K + 2, Len - (K + 1)),
            ReversedSuffix = lists:reverse(Suffix),

            ResultDigits = Prefix ++ ReversedSuffix,
            Result = digits_to_int(ResultDigits),

            % Step 5: Check for overflow
            if Result > MaxInt ->
                    -1;
                true ->
                    Result
            end
    end.

int_to_digits(N) ->
    [X - $0 || X <- integer_to_list(N)].

digits_to_int(Digits) ->
    list_to_integer([X + $0 || X <- Digits]).

find_k_idx(Digits, CurrentIdx) when CurrentIdx >= 0 ->
    D_current = lists:nth(CurrentIdx + 1, Digits),
    D_next = lists:nth(CurrentIdx + 2, Digits),
    if D_current < D_next ->
        CurrentIdx;
    true ->
        find_k_idx(Digits, CurrentIdx - 1)
    end;
find_k_idx(_Digits, _CurrentIdx) ->
    undefined. % No such k found

find_l_idx(Digits, K, Dk, CurrentIdx) when CurrentIdx > K ->
    D_current = lists:nth(CurrentIdx + 1, Digits),
    if D_current > Dk ->
        CurrentIdx;
    true ->
        find_l_idx(Digits, K, Dk, CurrentIdx - 1)
    end;
find_l_idx(_Digits, _K, _Dk, _CurrentIdx) ->
    % This case should ideally not be reached if K was found,
    % as there must be an element greater than Dk in the suffix.
    undefined.

swap_elements(List, Idx1, Idx2) ->
    E1 = lists:nth(Idx1 + 1, List),
    E2 = lists:nth(Idx2 + 1, List),
    List1 = set_nth(Idx1 + 1, E2, List),
    set_nth(Idx2 + 1, E1, List1).

set_nth(N, Val, L) ->
    {Before, [_|After]} = lists:split(N-1, L),
    Before ++ [Val|After].
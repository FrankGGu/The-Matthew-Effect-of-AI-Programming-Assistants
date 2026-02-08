-module(solution).
-export([shiftingLetters/2]).

shiftingLetters(S, Shifts) ->
    N = length(S),

    % 1. Create a difference array using gb_array for efficient updates.
    % Initialize with N+1 zeros.
    DiffArray = gb_array:new(N + 1, {default, 0}),

    % 2. Populate the difference array based on shifts.
    % gb_array:set returns a new gb_array, so we accumulate it in the fold.
    FinalDiffArray = lists:foldl(fun([Start, End, Dir], AccDiffArray) ->
                                     Value = if Dir == 1 -> 1; true -> -1 end,

                                     % Add Value at Start index
                                     CurrentStartVal = gb_array:get(Start, AccDiffArray),
                                     AccDiffArray1 = gb_array:set(Start, CurrentStartVal + Value, AccDiffArray),

                                     % Subtract Value at End + 1 index (if within bounds)
                                     if End + 1 < N + 1 ->
                                         CurrentEndPlus1Val = gb_array:get(End + 1, AccDiffArray1),
                                         gb_array:set(End + 1, CurrentEndPlus1Val - Value, AccDiffArray1);
                                     true ->
                                         AccDiffArray1
                                     end
                                 end, DiffArray, Shifts),

    % 3. Calculate the prefix sums to get the net shift for each character position.
    % We need N net shifts, corresponding to string indices 0 to N-1.
    NetShifts = calculate_net_shifts(gb_array:to_list(FinalDiffArray), N),

    % 4. Apply the calculated net shifts to the original string.
    apply_shifts_to_string(S, NetShifts).

calculate_net_shifts(DiffList, N) ->
    calculate_net_shifts_acc(DiffList, N, 0, []).

calculate_net_shifts_acc([], _N, _CurrentSum, Acc) ->
    lists:reverse(Acc);
calculate_net_shifts_acc([Head|Tail], N, CurrentSum, Acc) ->
    NewSum = CurrentSum + Head,
    % Only collect N net shifts (for string indices 0 to N-1)
    if length(Acc) < N ->
        calculate_net_shifts_acc(Tail, N, NewSum, [NewSum | Acc]);
    true ->
        % Once N shifts are collected, just consume the rest of DiffList
        calculate_net_shifts_acc(Tail, N, NewSum, Acc)
    end.

apply_shifts_to_string(S, NetShifts) ->
    lists:map(fun({Char, ShiftVal}) ->
                    % Convert character to 0-25 range ('a' is 0, 'z' is 25)
                    Base0Char = Char - $a,

                    % Apply shift and ensure result is within 0-25 range.
                    % The (+ 26) rem 26 handles negative results from rem.
                    ShiftedBase0Char = ((Base0Char + ShiftVal) rem 26 + 26) rem 26,

                    % Convert back to ASCII character code
                    ShiftedBase0Char + $a
                end, lists:zip(S, NetShifts)).
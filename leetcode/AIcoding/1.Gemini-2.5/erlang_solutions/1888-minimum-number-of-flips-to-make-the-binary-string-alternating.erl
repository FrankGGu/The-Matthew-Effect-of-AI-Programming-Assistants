-module(solution).
-export([min_flips/1]).

-include_lib("kernel/include/array.hrl").

min_flips(S) ->
    N = length(S),
    S_ext_list = S ++ S,
    S_ext_array = array:from_list(S_ext_list),

    % Calculate initial flips for the first window S_ext_array[0...N-1]
    % PatternType = 0 for '0101...' pattern, 1 for '1010...' pattern
    InitialFlips0 = calculate_initial_flips(S_ext_array, N, 0),
    InitialFlips1 = calculate_initial_flips(S_ext_array, N, 1),

    MinTotalFlips = min(InitialFlips0, InitialFlips1),

    % Slide the window
    slide_window(1, N, S_ext_array, InitialFlips0, InitialFlips1, MinTotalFlips).

calculate_initial_flips(Array, N, PatternType) ->
    calculate_initial_flips_acc(Array, N, 0, PatternType, 0).

calculate_initial_flips_acc(Array, N, CurrentIndex, PatternType, Acc) when CurrentIndex < N ->
    Char = array:get(CurrentIndex, Array),
    ExpectedChar = if PatternType == 0 -> % Target '0101...'
                       if (CurrentIndex rem 2) == 0 -> $0; true -> $1 end;
                   true -> % Target '1010...'
                       if (CurrentIndex rem 2) == 0 -> $1; true -> $0 end
                   end,
    NewAcc = if Char /= ExpectedChar -> Acc + 1; true -> Acc end,
    calculate_initial_flips_acc(Array, N, CurrentIndex + 1, PatternType, NewAcc);
calculate_initial_flips_acc(_Array, _N, _CurrentIndex, _PatternType, Acc) ->
    Acc.

slide_window(I, N, S_ext_array, CurrentFlips0, CurrentFlips1, MinTotalFlips) when I < N ->
    % Character leaving the window (at index I-1 in S_ext_array)
    LeftCharIdx = I - 1,
    LeftChar = array:get(LeftCharIdx, S_ext_array),

    % Character entering the window (at index I+N-1 in S_ext_array)
    RightCharIdx = I + N - 1,
    RightChar = array:get(RightCharIdx, S_ext_array),

    % Update CurrentFlips0 ('0101...' pattern)
    ExpectedLeftChar0 = if (LeftCharIdx rem 2) == 0 -> $0; true -> $1 end,
    NewFlips0 = if LeftChar /= ExpectedLeftChar0 -> CurrentFlips0 - 1; true -> CurrentFlips0 end,

    ExpectedRightChar0 = if (RightCharIdx rem 2) == 0 -> $0; true -> $1 end,
    NewFlips0_updated = if RightChar /= ExpectedRightChar0 -> NewFlips0 + 1; true -> NewFlips0 end,

    % Update CurrentFlips1 ('1010...' pattern)
    ExpectedLeftChar1 = if (LeftCharIdx rem 2) == 0 -> $1; true -> $0 end,
    NewFlips1 = if LeftChar /= ExpectedLeftChar1 -> CurrentFlips1 - 1; true -> CurrentFlips1 end,

    ExpectedRightChar1 = if (RightCharIdx rem 2) == 0 -> $1; true -> $0 end,
    NewFlips1_updated = if RightChar /= ExpectedRightChar1 -> NewFlips1 + 1; true -> NewFlips1 end,

    NewMinTotalFlips = min(MinTotalFlips, min(NewFlips0_updated, NewFlips1_updated)),

    slide_window(I + 1, N, S_ext_array, NewFlips0_updated, NewFlips1_updated, NewMinTotalFlips);
slide_window(_I, _N, _S_ext_array, _CurrentFlips0, _CurrentFlips1, MinTotalFlips) ->
    MinTotalFlips.
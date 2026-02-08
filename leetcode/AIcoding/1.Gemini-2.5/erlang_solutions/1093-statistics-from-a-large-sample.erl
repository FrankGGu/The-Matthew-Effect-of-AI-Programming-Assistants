-module(solution).
-export([sampleStats/1]).

sampleStats(Count) ->
    % Initial values for foldl:
    % TotalCount: Sum of all frequencies.
    % MinVal: Initialized to a value larger than any possible sample value (256).
    % MaxVal: Initialized to a value smaller than any possible sample value (-1).
    % Sum: Sum of (value * frequency).
    % MaxFreq: Maximum frequency encountered. Initialized to -1.
    % ModeVal: The value corresponding to MaxFreq. Initialized to -1.
    {TotalCount, MinVal, MaxVal, Sum, MaxFreq, ModeVal} =
        lists:foldl(
            fun(Idx, Acc) ->
                {CurrentTotalCount, CurrentMin, CurrentMax, CurrentSum, CurrentMaxFreq, CurrentModeVal} = Acc,
                Freq = element(Idx + 1, Count), % Erlang lists are 1-indexed for element/2

                NewTotalCount = CurrentTotalCount + Freq,
                NewSum = CurrentSum + Idx * Freq,

                % Update MinVal if current value has a frequency > 0 and is smaller
                NewMin = if Freq > 0, Idx < CurrentMin -> Idx;
                            true -> CurrentMin
                         end,
                % Update MaxVal if current value has a frequency > 0 and is larger
                NewMax = if Freq > 0, Idx > CurrentMax -> Idx;
                            true -> CurrentMax
                         end,

                % Update Mode if current frequency is greater than MaxFreq
                {NewMaxFreq, NewModeVal} = if Freq > CurrentMaxFreq -> {Freq, Idx};
                                             true -> {CurrentMaxFreq, CurrentModeVal}
                                          end,
                {NewTotalCount, NewMin, NewMax, NewSum, NewMaxFreq, NewModeVal}
            end,
            {0, 256, -1, 0, -1, -1}, % Initial {TotalCount, MinVal, MaxVal, Sum, MaxFreq, ModeVal}
            lists:seq(0, 255) % Iterate through possible values 0 to 255
        ),

    % Problem guarantees TotalCount > 0, so MinVal, MaxVal, MaxFreq, ModeVal will be correctly updated.

    % Calculate Mean
    Mean = Sum / TotalCount,

    % Calculate Median
    Median = calculate_median(Count, TotalCount),

    % Return results as a list of floats
    [MinVal * 1.0, MaxVal * 1.0, Mean, Median, ModeVal * 1.0].

calculate_median(Count, TotalCount) ->
    if TotalCount rem 2 == 1 ->
        % Odd number of elements: find the ((TotalCount div 2) + 1)-th element
        TargetK = (TotalCount div 2) + 1,
        find_kth_element(Count, TargetK, 0, 0)
    else
        % Even number of elements: average of (TotalCount div 2)-th and ((TotalCount div 2) + 1)-th elements
        TargetK1 = TotalCount div 2,
        TargetK2 = (TotalCount div 2) + 1,
        Val1 = find_kth_element(Count, TargetK1, 0, 0),
        Val2 = find_kth_element(Count, TargetK2, 0, 0),
        (Val1 + Val2) / 2.0
    end.

find_kth_element(Count, K, CurrentIdx, CurrentFreqSum) ->
    Freq = element(CurrentIdx + 1, Count),
    NewFreqSum = CurrentFreqSum + Freq,
    if NewFreqSum >= K ->
        CurrentIdx * 1.0; % Found the K-th element
    else
        find_kth_element(Count, K, CurrentIdx + 1, NewFreqSum)
    end.
-module(solution).
-export([subarraySum/2]).

subarraySum(Nums, K) ->
    % Acc is a map: #{current_sum => int(), count => int(), sum_freq => map()}
    % Initial state: current_sum = 0, count = 0, sum_freq = #{0 => 1}
    FinalAcc = lists:foldl(
        fun(Num, Acc) ->
            CurrentSum = maps:get(current_sum, Acc),
            Count = maps:get(count, Acc),
            SumFreq = maps:get(sum_freq, Acc),

            NewCurrentSum = CurrentSum + Num,
            Target = NewCurrentSum - K,

            % Get frequency of Target, default to 0 if not found
            TargetFreq = maps:get(Target, SumFreq, 0),
            NewCount = Count + TargetFreq,

            % Increment frequency of NewCurrentSum in SumFreq
            NewSumFreq = maps:update_with(NewCurrentSum, fun(Val) -> Val + 1 end, 1, SumFreq),

            Acc#{current_sum => NewCurrentSum, count => NewCount, sum_freq => NewSumFreq}
        end,
        #{current_sum => 0, count => 0, sum_freq => #{0 => 1}},
        Nums
    ),
    maps:get(count, FinalAcc).
-module(solution).
-export([leastInterval/2]).

leastInterval(Tasks, N) ->
    FreqMap = lists:foldl(fun(Task, Acc) -> maps:update_with(Task, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, Tasks),

    {MaxFreq, NumMaxFreqTasks} = find_max_freq_info(maps:values(FreqMap)),

    MinTimeByCooldown = (MaxFreq - 1) * (N + 1) + NumMaxFreqTasks,

    erlang:max(length(Tasks), MinTimeByCooldown).

find_max_freq_info(Freqs) ->
    lists:foldl(fun(Freq, {MaxF, NumMaxF}) ->
                        if Freq > MaxF -> {Freq, 1};
                           Freq == MaxF -> {MaxF, NumMaxF + 1};
                           true -> {MaxF, NumMaxF}
                        end
                end, {0, 0}, Freqs).
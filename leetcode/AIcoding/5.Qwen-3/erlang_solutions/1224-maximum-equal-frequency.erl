-module(max_equal_frequency).
-export([find_max_equal_frequency/1]).

find_max_equal_frequency(Nums) ->
    N = length(Nums),
    MaxFreq = 0,
    Count = maps:new(),
    Freq = maps:new(),
    loop(Nums, 0, Count, Freq, MaxFreq).

loop([], _Index, _Count, _Freq, MaxFreq) ->
    MaxFreq;
loop([N | Rest], Index, Count, Freq, MaxFreq) ->
    Count1 = maps:update_with(N, fun(V) -> V + 1 end, 1, Count),
    OldFreq = maps:get(N, Freq, 0),
    Freq1 = maps:remove(N, Freq),
    Freq2 = maps:update_with(OldFreq, fun(V) -> V - 1 end, 0, Freq1),
    Freq3 = maps:update_with(OldFreq + 1, fun(V) -> V + 1 end, 1, Freq2),
    CurrentMax = case maps:size(Freq3) of
        1 ->
            case maps:keys(Freq3) of
                [K] when K == 1 -> Index + 1;
                [K] when K == 0 -> Index + 1;
                _ -> MaxFreq
            end;
        _ ->
            case maps:values(Freq3) of
                [V1, V2] when (V1 == 1 andalso V2 == N - 1) orelse (V2 == 1 andalso V1 == N - 1) ->
                    Index + 1;
                _ ->
                    MaxFreq
            end
    end,
    loop(Rest, Index + 1, Count1, Freq3, CurrentMax).
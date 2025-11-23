-module(max_max_equal_freq).
-export([max_equal_freq/1]).

max_equal_freq(Nums) ->
    Freq = maps:new(),
    Count = maps:new(),
    max_equal_freq(Nums, Freq, Count, 0, 0).

max_equal_freq([], _Freq, _Count, MaxLen, _Len) ->
    MaxLen;
max_equal_freq([Num | Rest], Freq, Count, MaxLen, Len) ->
    OldCount = case maps:get(Num, Count, 0) of
                   0 -> 0;
                   C -> C
               end,
    NewCount = OldCount + 1,
    NewCount1 = case OldCount of
                    0 -> NewCount;
                    _ -> NewCount
                end,
    NewCount2 = case OldCount of
                    0 -> NewCount;
                    _ -> NewCount
                end,
    NewFreq = case OldCount of
                  0 -> Freq;
                  _ ->
                      case maps:get(OldCount, Freq, 0) of
                          1 -> maps:remove(OldCount, Freq);
                          N -> maps:put(OldCount, N - 1, Freq)
                      end
              end,
    NewFreq1 = maps:put(NewCount, maps:get(NewCount, NewFreq, 0) + 1, NewFreq),
    NewCount3 = maps:put(Num, NewCount, Count),
    Size = maps:size(NewFreq1),
    case Size of
        1 ->
            case maps:keys(NewFreq1) of
                [1] -> max_equal_freq(Rest, NewFreq1, NewCount3, Len + 1, Len + 1);
                [K] -> max_equal_freq(Rest, NewFreq1, NewCount3, Len + 1, Len + 1)
            end;
        2 ->
            [K1, K2] = lists:sort(maps:keys(NewFreq1)),
            case {K1, maps:get(K1, NewFreq1), K2, maps:get(K2, NewFreq1)} of
                {1, 1, _, _} -> max_equal_freq(Rest, NewFreq1, NewCount3, Len + 1, Len + 1);
                {_, _, K, 1} when K - K1 == 1 -> max_equal_freq(Rest, NewFreq1, NewCount3, Len + 1, Len + 1);
                _ -> max_equal_freq(Rest, NewFreq1, NewCount3, MaxLen, Len + 1)
            end;
        _ ->
            max_equal_freq(Rest, NewFreq1, NewCount3, MaxLen, Len + 1)
    end.
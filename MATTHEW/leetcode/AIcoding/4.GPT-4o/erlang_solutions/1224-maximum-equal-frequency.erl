-module(solution).
-export([max_equal_freq/1]).

max_equal_freq(List) ->
    FreqMap = lists:foldl(fun X, Acc ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:empty(), List),
    MaxFreq = maps:fold(fun({_, Freq}, Acc) -> max(Freq, Acc) end, 0, FreqMap),
    FreqCounts = maps:fold(fun({_, Freq}, Acc) ->
        maps:update_with(Freq, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:empty(), FreqMap),
    lists:max(lists:map(fun({Freq, Count}) -> 
        case Count of
            1 -> Freq * Count; % One element can be removed
            _ -> 
                case FreqCounts:find(Freq - 1) of
                    {ok, Count1} -> Freq * Count; % Reduce one freq count
                    _ -> 
                        case FreqCounts:find(Freq) of
                            {ok, Count2} -> 
                                case Count2 of
                                    1 -> Freq * (Count - 1); % Only one freq count
                                    _ -> Freq * Count % Keep as is
                                end;
                            _ -> Freq * Count
                        end
                end
        end
    end, maps:to_list(FreqCounts))).
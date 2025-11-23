-module(solution).
-export([longest_subarray/2]).

longest_subarray(List, K) ->
    longest_subarray(List, K, 0, 0, maps:new(), 0).

longest_subarray([], _, _, MaxLen, _, MaxLen) -> MaxLen;
longest_subarray([H | T], K, Count, Start, Freq, MaxLen) ->
    Freq1 = maps:update_with(H, fun(X) -> X + 1 end, 1, Freq),
    Count1 = maps:get(H, Freq1),
    NewStart = if Count1 > K -> 
                  case maps:fold(fun(_, V, Acc) -> 
                      if V > 1 -> 
                          Acc + 1; 
                      true -> 
                          Acc 
                      end 
                  end, 0, Freq1) of 
                      0 -> Start; 
                      _ -> Start + 1 
                  end; 
              true -> Start 
              end,
    NewMaxLen = max(MaxLen, length(List) - NewStart),
    longest_subarray(T, K, Count1, NewStart, Freq1, NewMaxLen).
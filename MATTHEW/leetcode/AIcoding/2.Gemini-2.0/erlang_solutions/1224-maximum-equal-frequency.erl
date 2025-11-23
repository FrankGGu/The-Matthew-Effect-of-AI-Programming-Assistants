-module(maximum_equal_frequency).
-export([max_equal_freq/1]).

max_equal_freq(Nums) ->
  max_equal_freq(Nums, #{}, #{}, 0, 0).

max_equal_freq([], _, _, MaxFreq, MaxLen) ->
  case MaxFreq of
    0 ->
      MaxLen;
    _ ->
      MaxLen
  end;
max_equal_freq([H|T], FreqMap, CountMap, MaxFreq, MaxLen) ->
  NewFreqMap = maps:update_with(H, fun(X) -> X + 1 end, 1, FreqMap),
  Freq = maps:get(H, NewFreqMap),
  NewCountMap =
    case maps:is_key(Freq, CountMap) of
      true ->
        case maps:get(Freq, CountMap) == 1 of
          true ->
            maps:remove(Freq, CountMap);
          false ->
            maps:update_with(Freq, fun(X) -> X - 1 end, 0, CountMap)
        end;
      false ->
        CountMap
    end,
  NewCountMap2 = maps:update_with(Freq + 1, fun(X) -> X + 1 end, 1, NewCountMap),
  NewMaxFreq = max(MaxFreq, Freq + 1),
  Len = length([H|T]),
  case check(NewCountMap2, NewMaxFreq, Len) of
    true ->
      max_equal_freq(T, NewFreqMap, NewCountMap2, NewMaxFreq, Len);
    false ->
      max_equal_freq(T, NewFreqMap, NewCountMap2, NewMaxFreq, MaxLen)
  end.

check(CountMap, MaxFreq, Len) ->
  case maps:size(CountMap) of
    1 ->
      case maps:size(CountMap) of
        1 ->
           case maps:to_list(CountMap) of
             [{1, _}] -> true;
             [{_M, 1}] -> true;
             _ -> false
           end;
        _ ->
          false
      end;
    2 ->
      case maps:to_list(CountMap) of
        [{1, 1}, {M, _}] when M == MaxFreq -> true;
        [{M, 1}, {1, _}] when M == 2 -> true;
        [{M, 1}, {M1, _}] when M + 1 == M1 andalso M1 == MaxFreq -> true;
        [{M1, _}, {M, 1}] when M + 1 == M1 andalso M1 == MaxFreq -> true;
        _ -> false
      end;
    _ ->
      false
  end.
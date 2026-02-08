-module(detect_pattern).
-export([detect_pattern/3]).

detect_pattern(Arr, M, K) ->
  Len = length(Arr),
  detect_pattern_helper(Arr, M, K, Len, 0).

detect_pattern_helper(_Arr, _M, _K, Len, I) when I + _M * _K > Len ->
  false;
detect_pattern_helper(Arr, M, K, Len, I) ->
  case check_pattern(Arr, M, K, I) of
    true ->
      true;
    false ->
      detect_pattern_helper(Arr, M, K, Len, I + 1)
  end.

check_pattern(Arr, M, K, Start) ->
  check_pattern_helper(Arr, M, K, Start, 1).

check_pattern_helper(Arr, M, K, Start, Count) when Count >= K ->
  true;
check_pattern_helper(Arr, M, K, Start, Count) ->
  Offset = Count * M,
  case check_equal(Arr, Start, Start + Offset, M) of
    true ->
      check_pattern_helper(Arr, M, K, Start, Count + 1);
    false ->
      false
  end.

check_equal(Arr, Start1, Start2, M) ->
  check_equal_helper(Arr, Start1, Start2, M, 0).

check_equal_helper(_Arr, _Start1, _Start2, M, I) when I >= M ->
  true;
check_equal_helper(Arr, Start1, Start2, M, I) ->
  case lists:nth(Start1 + I + 1, Arr) =:= lists:nth(Start2 + I + 1, Arr) of
    true ->
      check_equal_helper(Arr, Start1, Start2, M, I + 1);
    false ->
      false
  end.
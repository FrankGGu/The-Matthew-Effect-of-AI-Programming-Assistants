-module(max_diff).
-export([maxDiff/1]).

maxDiff(Num) ->
  Digits = integer_to_list(Num),
  Max = find_max(Digits),
  Min = find_min(Digits),
  Max - Min.

find_max(Digits) ->
  find_max_helper(Digits, 0).

find_max_helper([], Acc) ->
  Acc;
find_max_helper([H|T], Acc) ->
  case H of
    $9 ->
      find_max_helper(T, Acc * 10 + H);
    _ ->
      Replacement = H - $0,
      MaxDigit = find_replacement_max(Digits, Replacement),
      NewDigits = replace_all(Digits, Replacement, MaxDigit),
      list_to_integer(NewDigits)
  end.

find_replacement_max(Digits, Replacement) ->
  case find_first_non_nine(Digits) of
    none ->
      9;
    {Index, Digit} ->
      case Digit =:= Replacement + $0 of
        true -> 9;
        false -> 9
      end
  end.

find_first_non_nine([]) ->
  none;
find_first_non_nine([H|T]) ->
  case H =:= $9 of
    true ->
      find_first_non_nine(T);
    false ->
      {0, H}
  end.

find_min(Digits) ->
  find_min_helper(Digits, 0).

find_min_helper([], Acc) ->
  Acc;
find_min_helper([H|T], Acc) ->
  case H of
    $1 when Acc =:= 0 ->
      find_min_helper(T, Acc * 10 + H);
    $0 when Acc =:= 0 ->
      find_min_helper(T, Acc * 10 + H);
    _ ->
      Replacement = H - $0,
      MinDigit = find_replacement_min(Digits, Replacement, Acc),
      NewDigits = replace_all(Digits, Replacement, MinDigit),
      list_to_integer(NewDigits)
  end.

find_replacement_min(Digits, Replacement, Acc) ->
  case Acc =:= 0 of
    true ->
      case lists:nth(1,Digits) =:= $1 of
          true ->
              0;
          false ->
              1
      end;
    false ->
      0
  end.

replace_all([], _, _) ->
  [];
replace_all([H|T], Old, New) ->
  case H - $0 =:= Old of
    true ->
      [New + $0 | replace_all(T, Old, New)];
    false ->
      [H | replace_all(T, Old, New)]
  end.
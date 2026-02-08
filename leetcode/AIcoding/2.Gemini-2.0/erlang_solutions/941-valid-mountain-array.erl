-module(valid_mountain_array).
-export([validMountainArray/1]).

validMountainArray(Arr) ->
  Len = length(Arr),
  if Len < 3 then
    false
  else
    validMountainArray(Arr, 0, Len - 1, false)
  end.

validMountainArray(Arr, I, J, Increased) ->
  case {I >= J, Increased} of
    {true, true} ->
      true;
    {true, false} ->
      false;
    {false, _} ->
      case element(Arr, I + 1) > element(Arr, I) of
        true ->
          case element(Arr, I + 1) < element(Arr, I) of
            true -> false;
            false -> validMountainArray(Arr, I + 1, J, Increased)
          end;
        false ->
          case element(Arr, I + 1) < element(Arr, I) of
            true ->
              validMountainArray(Arr, I + 1, J, true);
            false ->
              false
          end
      end
  end.
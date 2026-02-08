-module(make_array_increasing).
-export([make_array_increasing/2]).

make_array_increasing(Arr1, Arr2) ->
  Arr2Sorted = lists:sort(Arr2),
  Arr2Unique = lists:usort(Arr2Sorted),
  Len1 = length(Arr1),
  Len2 = length(Arr2Unique),
  solve(Arr1, Arr2Unique).

solve(Arr1, Arr2Unique) ->
  Len1 = length(Arr1),
  Len2 = length(Arr2Unique),
  DP = array:new(Len1 + 1, {default, -1}),
  array:set(0, 0, DP),
  solve_helper(Arr1, Arr2Unique, DP, Len1).

solve_helper(Arr1, Arr2Unique, DP, Len1) ->
  Result = solve_recursive(Arr1, Arr2Unique, DP, Len1, -1, 0),
  case Result of
    infinity -> -1;
    _ -> Result
  end.

solve_recursive(Arr1, Arr2Unique, DP, I, Prev, J) ->
  case I of
    0 -> 0;
    _ ->
      case array:get(I, DP) of
        {default, -1} ->
          Res1 =
            case Arr1[I] > Prev of
              true -> solve_recursive(Arr1, Arr2Unique, DP, I - 1, Arr1[I], J);
              false -> infinity
            end,
          Res2 =
            case find_smallest_greater(Arr2Unique, Prev) of
              {found, Val} -> solve_recursive(Arr1, Arr2Unique, DP, I - 1, Val, J) + 1;
              not_found -> infinity
            end,
          Min = min(Res1, Res2),
          array:set(I, Min, DP),
          Min;
        Value -> Value
      end
  end.

find_smallest_greater(Arr, Prev) ->
  find_smallest_greater_helper(Arr, Prev, 1, length(Arr)).

find_smallest_greater_helper(Arr, Prev, Low, High) ->
  case Low > High of
    true -> not_found;
    false ->
      Mid = (Low + High) div 2,
      case Arr[Mid] > Prev of
        true ->
          case Mid == 1 orelse Arr[Mid - 1] =< Prev of
            true -> {found, Arr[Mid]};
            false -> find_smallest_greater_helper(Arr, Prev, Low, Mid - 1)
          end;
        false -> find_smallest_greater_helper(Arr, Prev, Mid + 1, High)
      end
  end.

min(A, B) ->
  case A < B of
    true -> A;
    false -> B
  end.
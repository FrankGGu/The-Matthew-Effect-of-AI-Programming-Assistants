-module(find_largest_almost_missing).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, length(Nums)).

solve(Nums, K) ->
  Len = length(Nums);
  SortedNums = lists:sort(Nums),
  solve_helper(SortedNums, 1, K, Len).

solve_helper([], Current, K, Len) ->
  case Current > Len + K of
    true -> Len;
    false -> Len
  end;
solve_helper([H|T], Current, K, Len) ->
  case H < Current of
    true ->
      solve_helper(T, Current, K, Len);
    false ->
      case H == Current of
        true ->
          solve_helper(T, Current + 1, K, Len);
        false ->
          case (H - Current) > K of
            true ->
              Current -1;
            false ->
              solve_helper(T, Current + 1, K - (H - Current)+1, Len)
          end
      end
  end.
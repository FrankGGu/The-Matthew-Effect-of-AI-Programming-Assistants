-module(equal_sum_arrays).
-export([minOperations/2]).

minOperations(Nums1, Nums2) ->
  S1 = lists:sum(Nums1),
  S2 = lists:sum(Nums2),
  if S1 == S2 ->
    0
  else
    (
      case S1 < S2 of
        true -> solve(Nums1, Nums2, S1, S2);
        false -> solve(Nums2, Nums1, S2, S1)
      end
    )
  end.

solve(Nums1, Nums2, S1, S2) ->
  if length(Nums1) * 6 < length(Nums2) then
    -1
  else
    Diff = S2 - S1,
    SortedNums1 = lists:sort(fun(A, B) -> A < B end, Nums1),
    SortedNums2 = lists:sort(fun(A, B) -> A > B end, Nums2),
    Combined = SortedNums2 ++ SortedNums1,
    solve_helper(Combined, Diff, 0)
  end.

solve_helper([], Diff, Count) ->
  if Diff =< 0 then
    Count
  else
    -1
  end;
solve_helper([H|T], Diff, Count) ->
  Change =
    case H of
      X when X > 6 -> 0;
      X when X < 1 -> 0;
      X ->
        case lists:member(X, lists:seq(1, 6)) of
          true ->
            6 - X;
          false ->
            X - 1
        end
    end,
  if Change >= Diff then
    Count + 1
  else
    solve_helper(T, Diff - Change, Count + 1)
  end.
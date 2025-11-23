-module(set_intersection_size_at_least_two).
-export([intersectionSizeTwo/1]).

intersectionSizeTwo(Intervals) ->
  SortedIntervals = lists:sort(fun({A1, B1}, {A2, B2}) ->
                                    if B1 < B2 then
                                      true
                                    else if B1 == B2 then
                                      A1 > A2
                                    else
                                      false
                                    end
                                end, Intervals),
  intersectionSizeTwoHelper(SortedIntervals, [], 0).

intersectionSizeTwoHelper([], _, Count) ->
  Count;
intersectionSizeTwoHelper([H|T], Acc, Count) ->
  {A, B} = H,
  case length(Acc) of
    0 ->
      intersectionSizeTwoHelper(T, [B-1, B], Count + 2);
    1 ->
      [X] = Acc,
      if X >= A then
        intersectionSizeTwoHelper(T, [X], Count)
      else
        intersectionSizeTwoHelper(T, [B-1, B], Count + 2)
      end;
    _ ->
      [_, Y] = lists:reverse(Acc),
      if Y >= A then
        intersectionSizeTwoHelper(T, Acc, Count)
      else if lists:nth(1, lists:reverse(Acc)) >= A then
          intersectionSizeTwoHelper(T, [Y, B], Count + 1)
      else
          intersectionSizeTwoHelper(T, [B-1, B], Count + 2)
      end
  end.
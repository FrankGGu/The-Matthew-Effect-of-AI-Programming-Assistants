-module(shortest_subarray_to_be_removed).
-export([find_length_of_shortest_subarray/1]).

find_length_of_shortest_subarray(Arr) ->
  find_length_of_shortest_subarray(Arr, 0, length(Arr) - 1).

find_length_of_shortest_subarray(Arr, L, R) ->
  N = length(Arr),
  {L1, R1} = find_left(Arr),
  {L2, R2} = find_right(Arr),

  if L1 >= R2 then
    0
  else

    Len1 = R2 - L1 - 1,
    Len2 = L2 - R1 - 1,
    Len3 = find_min_removed(Arr, L1, R2),
    min([Len1,Len2,Len3])
  end.

find_left(Arr) ->
  find_left(Arr, 0, length(Arr) - 1).

find_left(Arr, L, R) ->
  find_left(Arr, L, R, 0).

find_left(Arr, L, R, Acc) ->
  if L >= R then
    {L,R}
  else
    if lists:nth(L+1,Arr) <= lists:nth(L+2,Arr) then
      find_left(Arr,L+1,R,Acc)
    else
      {L,R}
    end
  end.

find_right(Arr) ->
  find_right(Arr, 0, length(Arr) - 1).

find_right(Arr, L, R) ->
  find_right(Arr, L, R, 0).

find_right(Arr, L, R, Acc) ->
  if L >= R then
    {L,R}
  else
    if lists:nth(R,Arr) >= lists:nth(R+1,Arr) then
      find_right(Arr,L,R-1,Acc)
    else
      {L,R}
    end
  end.

find_min_removed(Arr, L, R) ->
  find_min_removed(Arr, 0, R, L, length(Arr) -1, length(Arr)).

find_min_removed(Arr, I, J, L, R, MinLen) ->
  if I > L orelse J < R then
    MinLen
  else
    if lists:nth(I+1, Arr) <= lists:nth(J+1, Arr) then
        find_min_removed(Arr, I + 1, J, L, R, min([MinLen, J - I -1]))
    else
        find_min_removed(Arr, I, J-1, L, R, min([MinLen, J - I -1]))
    end
  end.
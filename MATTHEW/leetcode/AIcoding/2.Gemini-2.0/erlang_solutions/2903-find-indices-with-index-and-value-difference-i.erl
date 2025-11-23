-module(solution).
-export([find_indices/3]).

find_indices(Nums, IndexDifference, ValueDifference) ->
  find_indices_helper(Nums, IndexDifference, ValueDifference, 1, 1).

find_indices_helper(Nums, IndexDifference, ValueDifference, I, J) ->
  Len = length(Nums),
  if I > Len then
    [-1, -1]
  else
    if J > Len then
      find_indices_helper(Nums, IndexDifference, ValueDifference, I + 1, I + 1)
    else
      if abs(I - J) >= IndexDifference andalso abs(lists:nth(I, Nums) - lists:nth(J, Nums)) >= ValueDifference then
        [I - 1, J - 1]
      else
        find_indices_helper(Nums, IndexDifference, ValueDifference, I, J + 1)
      end
    end
  end.
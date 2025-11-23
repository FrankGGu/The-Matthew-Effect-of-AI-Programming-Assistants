-module(median_of_two_sorted_arrays).
-export([find_median_sorted_arrays/2]).

find_median_sorted_arrays(Nums1, Nums2) ->
  Len1 = length(Nums1),
  Len2 = length(Nums2),
  if Len1 > Len2 then
    find_median_sorted_arrays(Nums2, Nums1)
  else
    Len = Len1 + Len2,
    find_median(Nums1, Nums2, 0, Len1, Len)
  end.

find_median(Nums1, Nums2, Low, High, Len) ->
  PartitionX = (Low + High) div 2,
  PartitionY = (Len + 1) div 2 - PartitionX,
  MaxLeftX = if PartitionX =:= 0 then -infinity else lists:nth(PartitionX, Nums1) end,
  MinRightX = if PartitionX =:= length(Nums1) then infinity else lists:nth(PartitionX + 1, Nums1) end,
  MaxLeftY = if PartitionY =:= 0 then -infinity else lists:nth(PartitionY, Nums2) end,
  MinRightY = if PartitionY =:= length(Nums2) then infinity else lists:nth(PartitionY + 1, Nums2) end,
  if MaxLeftX =< MinRightY andalso MaxLeftY =< MinRightX then
    if Len rem 2 =:= 0 then
      (max(MaxLeftX, MaxLeftY) + min(MinRightX, MinRightY)) / 2.0
    else
      max(MaxLeftX, MaxLeftY)
    end
  else
    if MaxLeftX > MinRightY then
      find_median(Nums1, Nums2, Low, PartitionX - 1, Len)
    else
      find_median(Nums1, Nums2, PartitionX + 1, High, Len)
    end
  end.
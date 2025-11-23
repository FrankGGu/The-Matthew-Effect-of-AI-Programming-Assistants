-module(median_of_two_sorted_arrays).
-export([find_median_sorted_arrays/2]).

find_median_sorted_arrays(A, B) ->
    ListA = lists:sort(A),
    ListB = lists:sort(B),
    M = length(ListA),
    N = length(ListB),
    if
        M > N -> find_median_sorted_arrays(B, A);
        true -> find_median(A, B, 0, M, 0, N)
    end.

find_median(A, B, low, high, _, _) when low > high ->
    case (length(A) + length(B)) rem 2 of
        0 -> (lists:nth(1, A) + lists:nth(1, B)) / 2;
        _ -> lists:nth(1, A)
    end;

find_median(A, B, low, high, left, right) ->
    PartitionA = (low + high) div 2,
    PartitionB = ((length(A) + length(B) + 1) div 2) - PartitionA,

    MaxLeftA = if PartitionA == 0 -> -infinity; true -> lists:nth(PartitionA, A) end,
    MinRightA = if PartitionA == length(A) -> infinity; true -> lists:nth(PartitionA + 1, A) end,
    MaxLeftB = if PartitionB == 0 -> -infinity; true -> lists:nth(PartitionB, B) end,
    MinRightB = if PartitionB == length(B) -> infinity; true -> lists:nth(PartitionB + 1, B) end,

    if
        MaxLeftA =< MinRightB andalso MaxLeftB =< MinRightA ->
            case (length(A) + length(B)) rem 2 of
                0 -> (math:max(MaxLeftA, MaxLeftB) + math:min(MinRightA, MinRightB)) / 2;
                _ -> math:max(MaxLeftA, MaxLeftB)
            end;
        MaxLeftA > MinRightB -> find_median(A, B, low, PartitionA - 1, left, right);
        true -> find_median(A, B, PartitionA + 1, high, left, right)
    end.
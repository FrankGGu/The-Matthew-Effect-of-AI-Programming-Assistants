class Solution:
    def semiOrderedPermutation(self, nums: list[int]) -> int:
        n = len(nums)

        idx1 = nums.index(1)
        idxN = nums.index(n)

        swaps_for_1 = idx1

        # After 1 moves to index 0, its original position is filled by the element
        # that was at idx1 - 1. All elements from 0 to idx1 - 1 shift one position right.
        # We need to determine the new index of 'n'.
        # If 'n' was originally to the left of '1' (idxN < idx1),
        # then 'n' will be shifted one position to the right when '1' passes it.
        # If 'n' was originally to the right of '1' (idxN > idx1),
        # then '1' moving to the left does not affect 'n's position.

        current_idxN = idxN
        if idxN < idx1:
            current_idxN += 1

        swaps_for_n = (n - 1) - current_idxN

        return swaps_for_1 + swaps_for_n
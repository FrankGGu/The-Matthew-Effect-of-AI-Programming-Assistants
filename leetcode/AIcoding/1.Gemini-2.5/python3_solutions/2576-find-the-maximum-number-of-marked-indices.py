class Solution:
    def maxNumOfMarkedIndices(self, nums: list[int]) -> int:
        nums.sort()
        n = len(nums)

        count = 0
        i = 0  # Pointer for elements from the first half (conceptually)
        j = n // 2 # Pointer for elements from the second half (conceptually)

        while i < n // 2 and j < n:
            if 2 * nums[i] <= nums[j]:
                # Found a valid pair (nums[i], nums[j])
                count += 1
                i += 1 # Move to the next element in the first half
                j += 1 # Move to the next element in the second half
            else:
                # nums[j] is too small for nums[i].
                # Try a larger element from the second half.
                j += 1

        return 2 * count
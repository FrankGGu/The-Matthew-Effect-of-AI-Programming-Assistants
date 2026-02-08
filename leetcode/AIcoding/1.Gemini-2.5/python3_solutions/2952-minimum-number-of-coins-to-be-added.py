class Solution:
    def minPatches(self, nums: list[int], n: int) -> int:
        patches = 0
        reach = 0  # Represents the maximum sum we can currently form
        i = 0      # Pointer for the nums array

        while reach < n:
            if i < len(nums) and nums[i] <= reach + 1:
                # If the current coin can extend our reach, use it
                reach += nums[i]
                i += 1
            else:
                # Gap found: reach + 1 cannot be formed.
                # We must add a coin. The most efficient coin to add is (reach + 1).
                # Adding (reach + 1) extends our reach to reach + (reach + 1).
                reach += (reach + 1)
                patches += 1

        return patches
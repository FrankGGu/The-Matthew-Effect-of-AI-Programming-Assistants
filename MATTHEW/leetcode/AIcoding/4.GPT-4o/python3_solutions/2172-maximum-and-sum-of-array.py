class Solution:
    def maximumANDSum(self, nums: List[int], numSlots: int) -> int:
        from itertools import combinations

        def backtrack(i, slots):
            if i == len(nums):
                return 0
            max_sum = 0
            for j in range(numSlots):
                if slots[j] < 2:
                    slots[j] += 1
                    max_sum = max(max_sum, (nums[i] & (j + 1)) + backtrack(i + 1, slots))
                    slots[j] -= 1
            return max_sum

        return backtrack(0, [0] * numSlots)
from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0
        if n == 1:
            return nums[0]

        def rob_linear(arr: List[int]) -> int:
            if not arr:
                return 0
            if len(arr) == 1:
                return arr[0]

            prev2 = arr[0]
            prev1 = max(arr[0], arr[1])

            for i in range(2, len(arr)):
                current_max = max(prev1, prev2 + arr[i])
                prev2 = prev1
                prev1 = current_max
            return prev1

        return max(rob_linear(nums[0:n-1]), rob_linear(nums[1:n]))
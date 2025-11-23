from typing import List

class Solution:
    def numberOfBeautifulTowers(self, nums: List[int]) -> int:
        n = len(nums)
        left = [0] * n
        right = [0] * n

        for i in range(n):
            if i == 0:
                left[i] = nums[i]
            else:
                left[i] = left[i - 1] + nums[i]

        for i in range(n - 1, -1, -1):
            if i == n - 1:
                right[i] = nums[i]
            else:
                right[i] = right[i + 1] + nums[i]

        result = 0
        for i in range(n):
            total = left[i] + right[i] - nums[i]
            if total > 0:
                result += 1

        return result
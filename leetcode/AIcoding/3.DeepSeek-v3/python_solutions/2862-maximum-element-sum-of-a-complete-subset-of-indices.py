import math

class Solution:
    def maximumSum(self, nums: List[int]) -> int:
        n = len(nums)
        max_sum = -float('inf')
        visited = [False] * (n + 1)

        for i in range(1, n + 1):
            if not visited[i]:
                current_sum = 0
                j = 1
                while j * j * i <= n:
                    idx = j * j * i
                    current_sum += nums[idx - 1]
                    visited[idx] = True
                    j += 1
                if current_sum > max_sum:
                    max_sum = current_sum
        return max_sum
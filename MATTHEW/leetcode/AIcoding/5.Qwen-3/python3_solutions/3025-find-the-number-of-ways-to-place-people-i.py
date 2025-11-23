class Solution:
    def numberOfWays(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        left = [0] * n
        right = [0] * n

        for i in range(n):
            for j in range(i + 1, n):
                if nums[j] < nums[i]:
                    left[i] += 1
                elif nums[j] > nums[i]:
                    right[i] += 1

        res = 0
        for i in range(n):
            res += left[i] * right[i]

        return res
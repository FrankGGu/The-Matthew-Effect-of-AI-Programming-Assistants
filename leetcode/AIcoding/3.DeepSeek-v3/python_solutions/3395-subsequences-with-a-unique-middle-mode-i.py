class Solution:
    def countSubsequences(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        res = 0

        for i in range(n):
            left = {}
            right = {}
            for j in range(i - 1, -1, -1):
                if nums[j] < nums[i]:
                    left[nums[j]] = left.get(nums[j], 0) + 1
            for j in range(i + 1, n):
                if nums[j] > nums[i]:
                    right[nums[j]] = right.get(nums[j], 0) + 1

            l_count = sum(left.values())
            r_count = sum(right.values())
            res = (res + l_count * r_count) % MOD

        return res
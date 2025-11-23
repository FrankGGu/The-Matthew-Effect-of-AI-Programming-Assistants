class Solution:
    def maximumOr(self, nums: List[int], k: int) -> int:
        max_or = 0
        n = len(nums)
        prefix = [0] * (n + 1)
        suffix = [0] * (n + 1)

        for i in range(n):
            prefix[i + 1] = prefix[i] | nums[i]

        for i in range(n - 1, -1, -1):
            suffix[i] = suffix[i + 1] | nums[i]

        for i in range(n):
            max_or = max(max_or, prefix[i] | (suffix[i + 1] + k))

        return max_or
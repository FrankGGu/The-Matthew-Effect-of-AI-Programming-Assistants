class Solution:
    def countBeautifulSplits(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        prefix = [0] * n
        suffix = [0] * n

        prefix[0] = nums[0]
        for i in range(1, n):
            prefix[i] = prefix[i - 1] + nums[i]

        suffix[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            suffix[i] = suffix[i + 1] + nums[i]

        count = 0
        for i in range(1, n - 1):
            left_sum = prefix[i]
            right_sum = suffix[i + 1]
            if left_sum < right_sum:
                count += 1

        return count
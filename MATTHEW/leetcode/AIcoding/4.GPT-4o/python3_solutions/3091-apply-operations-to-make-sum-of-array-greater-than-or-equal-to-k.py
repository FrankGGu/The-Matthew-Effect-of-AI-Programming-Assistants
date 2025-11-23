class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        if prefix_sum[n] < k:
            return -1

        left = 0
        right = 0
        min_ops = float('inf')

        while right < n:
            while right < n and prefix_sum[right + 1] - prefix_sum[left] < k:
                right += 1
            if right < n:
                min_ops = min(min_ops, right - left + 1)
            left += 1

        return min_ops if min_ops != float('inf') else -1
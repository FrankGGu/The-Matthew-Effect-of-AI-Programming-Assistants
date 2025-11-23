class Solution:
    def minimumAverageDifference(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        total_sum = prefix_sum[n]
        min_avg_diff = float('inf')
        result = 0

        for i in range(n):
            left_sum = prefix_sum[i + 1]
            left_avg = left_sum // (i + 1)

            right_sum = total_sum - left_sum
            if i != n - 1:
                right_avg = right_sum // (n - i - 1)
            else:
                right_avg = 0

            avg_diff = abs(left_avg - right_avg)
            if avg_diff < min_avg_diff:
                min_avg_diff = avg_diff
                result = i

        return result
class Solution:
    def minimumAverageDifference(self, nums: List[int]) -> int:
        n = len(nums)
        total_sum = sum(nums)
        min_avg_diff = float('inf')
        min_index = -1
        left_sum = 0

        for i in range(n):
            left_sum += nums[i]
            right_sum = total_sum - left_sum

            left_avg = left_sum // (i + 1)
            right_avg = right_sum // (n - i - 1) if n - i - 1 > 0 else 0

            avg_diff = abs(left_avg - right_avg)

            if avg_diff < min_avg_diff:
                min_avg_diff = avg_diff
                min_index = i

        return min_index
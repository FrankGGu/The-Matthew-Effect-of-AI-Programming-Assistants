class Solution:
    def minimumAverageDifference(self, nums: list[int]) -> int:
        n = len(nums)

        total_sum = sum(nums)

        min_avg_diff = float('inf')
        min_index = -1

        current_prefix_sum = 0

        for i in range(n):
            current_prefix_sum += nums[i]

            avg1 = current_prefix_sum // (i + 1)

            remaining_sum = total_sum - current_prefix_sum
            remaining_count = n - (i + 1)

            avg2 = 0
            if remaining_count > 0:
                avg2 = remaining_sum // remaining_count

            current_diff = abs(avg1 - avg2)

            if current_diff < min_avg_diff:
                min_avg_diff = current_diff
                min_index = i

        return min_index
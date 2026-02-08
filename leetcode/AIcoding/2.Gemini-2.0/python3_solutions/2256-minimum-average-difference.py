class Solution:
    def minimumAverageDifference(self, nums: List[int]) -> int:
        n = len(nums)
        total_sum = sum(nums)
        curr_sum = 0
        min_avg_diff = float('inf')
        min_index = 0

        for i in range(n):
            curr_sum += nums[i]
            avg1 = curr_sum // (i + 1)

            if i == n - 1:
                avg2 = 0
            else:
                avg2 = (total_sum - curr_sum) // (n - i - 1)

            diff = abs(avg1 - avg2)

            if diff < min_avg_diff:
                min_avg_diff = diff
                min_index = i

        return min_index
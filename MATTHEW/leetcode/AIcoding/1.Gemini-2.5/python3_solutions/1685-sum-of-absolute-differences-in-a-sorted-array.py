class Solution:
    def getSumAbsoluteDifferences(self, nums: list[int]) -> list[int]:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        result = [0] * n
        for i in range(n):
            # Sum of differences for elements to the left: (nums[i] - nums[0]) + ... + (nums[i] - nums[i-1])
            # = i * nums[i] - (nums[0] + ... + nums[i-1])
            # = i * nums[i] - prefix_sum[i]
            left_diff_sum = i * nums[i] - prefix_sum[i]

            # Sum of differences for elements to the right: (nums[i+1] - nums[i]) + ... + (nums[n-1] - nums[i])
            # = (nums[i+1] + ... + nums[n-1]) - (n - 1 - i) * nums[i]
            # (nums[i+1] + ... + nums[n-1]) is total_sum - (nums[0] + ... + nums[i])
            # = prefix_sum[n] - prefix_sum[i+1]
            right_diff_sum = (prefix_sum[n] - prefix_sum[i+1]) - (n - 1 - i) * nums[i]

            result[i] = left_diff_sum + right_diff_sum

        return result
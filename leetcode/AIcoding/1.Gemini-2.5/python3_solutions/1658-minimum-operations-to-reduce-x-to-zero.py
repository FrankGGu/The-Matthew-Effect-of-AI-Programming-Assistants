class Solution:
    def minOperations(self, nums: list[int], x: int) -> int:
        n = len(nums)
        total_sum = sum(nums)

        target_sum = total_sum - x

        if target_sum < 0:
            return -1

        max_len = -1
        current_sum = 0
        left = 0

        for right in range(n):
            current_sum += nums[right]

            while current_sum > target_sum and left <= right:
                current_sum -= nums[left]
                left += 1

            if current_sum == target_sum:
                max_len = max(max_len, right - left + 1)

        if max_len == -1:
            return -1
        else:
            return n - max_len
class Solution:
    def minTime(self, nums: List[int], x: int) -> int:
        n = len(nums)
        total_sum = sum(nums)
        target = total_sum - x

        if target < 0:
            return -1

        left = 0
        current_sum = 0
        max_length = -1

        for right in range(n):
            current_sum += nums[right]
            while current_sum > target:
                current_sum -= nums[left]
                left += 1
            if current_sum == target:
                max_length = max(max_length, right - left + 1)

        return n - max_length if max_length != -1 else -1
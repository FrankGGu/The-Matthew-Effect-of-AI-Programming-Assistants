class Solution:
    def minOperations(self, nums: List[int], x: int) -> int:
        total = sum(nums)
        target = total - x
        n = len(nums)
        left, current_sum, max_length = 0, 0, -1

        for right in range(n):
            current_sum += nums[right]
            while current_sum > target and left <= right:
                current_sum -= nums[left]
                left += 1
            if current_sum == target:
                max_length = max(max_length, right - left + 1)

        return n - max_length if max_length != -1 else -1
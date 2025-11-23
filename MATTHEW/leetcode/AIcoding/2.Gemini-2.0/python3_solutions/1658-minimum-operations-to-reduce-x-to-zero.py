class Solution:
    def minOperations(self, nums: List[int], x: int) -> int:
        target = sum(nums) - x
        curr_sum = 0
        max_len = -1
        left = 0
        for right, num in enumerate(nums):
            curr_sum += num
            while curr_sum > target and left <= right:
                curr_sum -= nums[left]
                left += 1
            if curr_sum == target:
                max_len = max(max_len, right - left + 1)

        return len(nums) - max_len if max_len != -1 else -1
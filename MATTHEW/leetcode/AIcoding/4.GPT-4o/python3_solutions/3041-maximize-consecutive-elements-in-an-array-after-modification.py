class Solution:
    def maximumConsecutive(self, nums: List[int], k: int) -> int:
        nums.sort()
        left = 0
        max_length = 0

        for right in range(len(nums)):
            while nums[right] - nums[left] > k:
                left += 1
            max_length = max(max_length, right - left + 1)

        return max_length
class Solution:
    def maximumUniqueSubarray(self, nums: list[int]) -> int:
        max_sum = 0
        current_sum = 0
        seen = set()
        left = 0

        for right in range(len(nums)):
            while nums[right] in seen:
                current_sum -= nums[left]
                seen.remove(nums[left])
                left += 1

            current_sum += nums[right]
            seen.add(nums[right])
            max_sum = max(max_sum, current_sum)

        return max_sum
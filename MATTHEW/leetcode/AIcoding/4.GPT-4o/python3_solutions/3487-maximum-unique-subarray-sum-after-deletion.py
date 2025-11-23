class Solution:
    def maximumUniqueSubarray(self, nums: List[int]) -> int:
        seen = set()
        max_sum = current_sum = left = 0

        for right in range(len(nums)):
            while nums[right] in seen:
                seen.remove(nums[left])
                current_sum -= nums[left]
                left += 1
            seen.add(nums[right])
            current_sum += nums[right]
            max_sum = max(max_sum, current_sum)

        return max_sum
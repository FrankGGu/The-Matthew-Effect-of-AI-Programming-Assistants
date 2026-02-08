class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        prefix_sum = 0
        left = 0
        count = 0

        for right in range(len(nums)):
            prefix_sum += nums[right]
            while prefix_sum >= k:
                prefix_sum -= nums[left]
                left += 1
            count += right - left + 1

        return count
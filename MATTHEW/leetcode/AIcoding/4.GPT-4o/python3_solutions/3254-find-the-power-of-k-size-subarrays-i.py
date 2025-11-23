class Solution:
    def countKSubarrays(self, nums: List[int], k: int) -> int:
        count = 0
        curr_sum = 0
        left = 0
        for right in range(len(nums)):
            curr_sum += nums[right]
            while curr_sum > k:
                curr_sum -= nums[left]
                left += 1
            if curr_sum == k:
                count += 1
        return count
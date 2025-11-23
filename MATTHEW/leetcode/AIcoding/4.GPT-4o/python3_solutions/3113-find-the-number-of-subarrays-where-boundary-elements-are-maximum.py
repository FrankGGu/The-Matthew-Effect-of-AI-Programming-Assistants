class Solution:
    def countSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        total_subarrays = 0

        for i in range(n):
            left = right = i

            while left >= 0 and nums[left] <= nums[i]:
                left -= 1
            while right < n and nums[right] <= nums[i]:
                right += 1

            total_subarrays += (i - left) * (right - i)

        return total_subarrays
class Solution:
    def findThePowerOfKSubarrays(self, nums: list[int], k: int) -> list[int]:
        n = len(nums)
        if n < k:
            return []

        result = []
        current_sum = 0

        for i in range(k):
            current_sum += nums[i]
        result.append(current_sum)

        for i in range(k, n):
            current_sum += nums[i] - nums[i - k]
            result.append(current_sum)

        return result
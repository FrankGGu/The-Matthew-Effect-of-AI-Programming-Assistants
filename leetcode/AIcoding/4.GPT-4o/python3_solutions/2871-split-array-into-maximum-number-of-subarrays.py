class Solution:
    def maxSubarrays(self, nums: List[int]) -> int:
        total_xor = 0
        for num in nums:
            total_xor ^= num

        if total_xor == 0:
            return len(nums)

        count = 0
        current_xor = 0

        for num in nums:
            current_xor ^= num
            if current_xor == total_xor:
                count += 1
                current_xor = 0

        return count
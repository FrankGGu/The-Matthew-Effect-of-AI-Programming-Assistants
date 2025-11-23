class Solution:
    def maxSubarrays(self, nums: List[int]) -> int:
        min_and = nums[0]
        for num in nums[1:]:
            min_and &= num
        if min_and != 0:
            return 1

        res = 0
        current_and = (1 << 30) - 1
        for num in nums:
            current_and &= num
            if current_and == 0:
                res += 1
                current_and = (1 << 30) - 1
        return res
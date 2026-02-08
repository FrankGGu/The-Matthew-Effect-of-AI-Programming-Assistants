class Solution:
    def canMakeSubarraySumsZero(self, nums: List[int]) -> bool:
        prefix_sum = 0
        seen = {0}
        for num in nums:
            prefix_sum += num
            if prefix_sum in seen:
                return True
            seen.add(prefix_sum)
        return False
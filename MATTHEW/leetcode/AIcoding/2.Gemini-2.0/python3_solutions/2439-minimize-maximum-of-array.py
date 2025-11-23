class Solution:
    def minimizeArrayValue(self, nums: List[int]) -> int:
        total = 0
        ans = 0
        for i, num in enumerate(nums):
            total += num
            ans = max(ans, (total + i) // (i + 1))
        return ans
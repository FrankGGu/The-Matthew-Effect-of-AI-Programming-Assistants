class Solution:
    def findSubarrayWithOR(self, nums: List[int], k: int) -> int:
        n = len(nums)
        ans = float('inf')
        for i in range(n):
            curr_or = 0
            for j in range(i, n):
                curr_or |= nums[j]
                diff = abs(curr_or - k)
                ans = min(ans, diff)
        return ans
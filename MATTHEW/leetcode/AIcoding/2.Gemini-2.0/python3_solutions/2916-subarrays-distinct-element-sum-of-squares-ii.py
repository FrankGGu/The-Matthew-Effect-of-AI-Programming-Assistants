class Solution:
    def sumCounts(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        ans = 0
        for i in range(n):
            distinct = set()
            for j in range(i, n):
                distinct.add(nums[j])
                ans = (ans + len(distinct)**2) % MOD
        return ans
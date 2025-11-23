class Solution:
    def sumCounts(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        total = 0

        for i in range(n):
            distinct = set()
            for j in range(i, n):
                distinct.add(nums[j])
                count = len(distinct)
                total = (total + count * count) % MOD

        return total
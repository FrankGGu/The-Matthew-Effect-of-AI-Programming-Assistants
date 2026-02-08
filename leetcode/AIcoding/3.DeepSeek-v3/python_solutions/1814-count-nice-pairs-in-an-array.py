class Solution:
    def countNicePairs(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        freq = {}
        res = 0
        for num in nums:
            rev = int(str(num)[::-1])
            diff = num - rev
            res = (res + freq.get(diff, 0)) % MOD
            freq[diff] = freq.get(diff, 0) + 1
        return res
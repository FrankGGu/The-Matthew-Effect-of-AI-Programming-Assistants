class Solution:
    def countNicePairs(self, nums: List[int]) -> int:
        from collections import defaultdict

        mod = 10**9 + 7
        count = 0
        freq = defaultdict(int)

        for num in nums:
            rev = int(str(num)[::-1])
            count = (count + freq[num - rev]) % mod
            freq[rev] += 1

        return count
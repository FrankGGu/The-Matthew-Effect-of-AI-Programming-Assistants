class Solution:
    def maximumExcellentPairs(self, nums: List[int]) -> int:
        from collections import Counter

        def countSetBits(x):
            return bin(x).count('1')

        cnt = Counter()
        for num in nums:
            bits = countSetBits(num)
            cnt[bits] += 1

        res = 0
        for a in cnt:
            for b in cnt:
                if a + b >= 2:
                    res += cnt[a] * cnt[b]
        return res
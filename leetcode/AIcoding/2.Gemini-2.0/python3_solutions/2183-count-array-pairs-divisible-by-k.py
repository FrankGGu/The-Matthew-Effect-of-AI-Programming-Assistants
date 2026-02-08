from collections import defaultdict
from math import gcd

class Solution:
    def countPairs(self, nums: list[int], k: int) -> int:
        count = 0
        freq = defaultdict(int)
        for num in nums:
            g = gcd(num, k)
            for f in freq:
                if (g * f) % k == 0:
                    count += freq[f]
            freq[g] += 1
        return count
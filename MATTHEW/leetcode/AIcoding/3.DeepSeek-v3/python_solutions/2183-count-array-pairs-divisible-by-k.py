import math
from collections import defaultdict

class Solution:
    def countPairs(self, nums: List[int], k: int) -> int:
        freq = defaultdict(int)
        res = 0
        for num in nums:
            gcd_num = math.gcd(num, k)
            for d in freq:
                if (d * gcd_num) % k == 0:
                    res += freq[d]
            freq[gcd_num] += 1
        return res
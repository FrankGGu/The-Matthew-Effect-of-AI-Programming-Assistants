from typing import List
from collections import defaultdict

class Solution:
    def beautifulSubarrays(self, nums: List[int]) -> int:
        count = 0
        prefix_xor = 0
        xor_count = defaultdict(int)
        xor_count[0] = 1

        for num in nums:
            prefix_xor ^= num
            count += xor_count[prefix_xor]
            xor_count[prefix_xor] += 1

        return count
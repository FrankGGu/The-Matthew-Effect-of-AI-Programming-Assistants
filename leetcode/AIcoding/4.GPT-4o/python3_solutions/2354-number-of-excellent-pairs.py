from collections import Counter

class Solution:
    def countExcellentPairs(self, nums: List[int], k: int) -> int:
        count = Counter(bin(num).count('1') for num in set(nums))
        max_bits = max(count)
        result = 0
        for bits in count:
            if bits + max_bits >= k:
                result += count[bits] * sum(count[c] for c in count if c + bits >= k)
        return result
from collections import defaultdict

class Solution:
    def countCompleteDayPairs(self, hours: List[int]) -> int:
        mod_counts = defaultdict(int)
        count = 0
        for hour in hours:
            mod = hour % 24
            complement = (24 - mod) % 24
            count += mod_counts.get(complement, 0)
            mod_counts[mod] += 1
        return count
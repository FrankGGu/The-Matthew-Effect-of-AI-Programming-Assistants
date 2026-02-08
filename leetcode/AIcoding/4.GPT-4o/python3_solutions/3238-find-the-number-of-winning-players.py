from collections import Counter

class Solution:
    def numberOfWinningPlayers(self, nums: List[int]) -> int:
        count = Counter(nums)
        max_count = max(count.values())
        return sum(1 for v in count.values() if v == max_count)
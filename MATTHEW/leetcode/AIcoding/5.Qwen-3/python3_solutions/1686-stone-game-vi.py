class Solution:
    def stoneGameIX(self, stones: List[int]) -> int:
        from collections import Counter

        count = Counter(stones)
        mod_counts = [0, 0, 0]
        for stone in stones:
            mod_counts[stone % 3] += 1

        if mod_counts[0] % 2 == 0:
            return min(mod_counts[1], mod_counts[2]) * 2
        else:
            return min(mod_counts[1], mod_counts[2]) * 2 + 1
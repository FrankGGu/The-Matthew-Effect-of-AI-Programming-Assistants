class Solution:
    def countPairs(self, coordinates: List[List[int]], k: int) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        res = 0
        for x, y in coordinates:
            for a in range(k + 1):
                b = k - a
                res += count.get((x ^ a, y ^ b), 0)
            count[(x, y)] += 1
        return res
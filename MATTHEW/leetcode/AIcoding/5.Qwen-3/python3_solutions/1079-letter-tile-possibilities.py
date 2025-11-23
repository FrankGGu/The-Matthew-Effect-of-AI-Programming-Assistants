class Solution:
    def numTilePossibilities(self, tiles: str) -> int:
        from collections import Counter

        def dfs(count):
            res = 0
            for c in count:
                if count[c] > 0:
                    count[c] -= 1
                    res += 1 + dfs(count)
                    count[c] += 1
            return res

        return dfs(Counter(tiles))
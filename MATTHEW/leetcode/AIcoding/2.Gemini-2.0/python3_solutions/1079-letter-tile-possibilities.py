from collections import Counter

class Solution:
    def numTilePossibilities(self, tiles: str) -> int:
        count = Counter(tiles)
        self.res = 0

        def backtrack(length):
            if length > 0:
                self.res += 1

            for char in count:
                if count[char] > 0:
                    count[char] -= 1
                    backtrack(length + 1)
                    count[char] += 1

        backtrack(0)
        return self.res
class Solution:
    def numTilePossibilities(self, tiles: str) -> int:
        from collections import Counter

        def backtrack(counter):
            total = 0
            for char in counter:
                if counter[char] > 0:
                    total += 1
                    counter[char] -= 1
                    total += backtrack(counter)
                    counter[char] += 1
            return total

        counter = Counter(tiles)
        return backtrack(counter)
import collections

class Solution:
    def numTilePossibilities(self, tiles: str) -> int:
        counts = collections.Counter(tiles)

        self.result_count = 0

        def backtrack():
            for char_code in range(ord('A'), ord('Z') + 1):
                char = chr(char_code)

                if counts[char] > 0:
                    self.result_count += 1

                    counts[char] -= 1
                    backtrack()
                    counts[char] += 1

        backtrack()
        return self.result_count
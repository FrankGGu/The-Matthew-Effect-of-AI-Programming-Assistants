from collections import defaultdict

class Solution:
    def maxEqualRowsAfterFlips(self, matrix: list[list[int]]) -> int:
        count = defaultdict(int)
        for row in matrix:
            s = tuple(0 if x == row[0] else 1 for x in row)
            count[s] += 1
        return max(count.values())
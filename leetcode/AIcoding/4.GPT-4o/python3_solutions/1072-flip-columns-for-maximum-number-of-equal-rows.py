class Solution:
    def maxEqualRowsAfterFlips(self, matrix: List[List[int]]) -> int:
        from collections import defaultdict

        count = defaultdict(int)

        for row in matrix:
            normalized = tuple(row) if row[0] == 0 else tuple(1 - x for x in row)
            count[normalized] += 1

        return max(count.values())
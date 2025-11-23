class Solution:
    def maxEqualRowsAfterFlip(self, matrix: List[List[int]]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for row in matrix:
            key = tuple(row)
            if row[0] == 1:
                key = tuple(1 - x for x in row)
            count[key] += 1

        return max(count.values())
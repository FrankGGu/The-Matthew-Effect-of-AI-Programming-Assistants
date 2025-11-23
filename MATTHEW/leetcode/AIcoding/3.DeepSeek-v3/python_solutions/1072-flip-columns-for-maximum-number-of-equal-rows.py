class Solution:
    def maxEqualRowsAfterFlips(self, matrix: List[List[int]]) -> int:
        from collections import defaultdict

        pattern_count = defaultdict(int)

        for row in matrix:
            pattern = []
            flip = row[0] == 0
            for num in row:
                if flip:
                    pattern.append(1 - num)
                else:
                    pattern.append(num)
            pattern_tuple = tuple(pattern)
            pattern_count[pattern_tuple] += 1

        return max(pattern_count.values()) if pattern_count else 0
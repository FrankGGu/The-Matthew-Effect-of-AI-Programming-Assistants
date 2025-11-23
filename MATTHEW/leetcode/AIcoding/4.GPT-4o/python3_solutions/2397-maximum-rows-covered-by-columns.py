class Solution:
    def maximumRows(self, mat: List[List[int]], cols: int) -> int:
        from itertools import combinations

        m, n = len(mat), len(mat[0])
        max_covered = 0

        for comb in combinations(range(n), cols):
            covered = sum(all(mat[row][col] == 0 for col in comb) for row in range(m))
            max_covered = max(max_covered, covered)

        return max_covered
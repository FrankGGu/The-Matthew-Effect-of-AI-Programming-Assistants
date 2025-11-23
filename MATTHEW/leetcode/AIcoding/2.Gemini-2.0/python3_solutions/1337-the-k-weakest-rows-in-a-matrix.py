class Solution:
    def kWeakestRows(self, mat: List[List[int]], k: int) -> List[int]:
        rows = []
        for i, row in enumerate(mat):
            strength = sum(row)
            rows.append((strength, i))

        rows.sort()

        result = []
        for i in range(k):
            result.append(rows[i][1])

        return result
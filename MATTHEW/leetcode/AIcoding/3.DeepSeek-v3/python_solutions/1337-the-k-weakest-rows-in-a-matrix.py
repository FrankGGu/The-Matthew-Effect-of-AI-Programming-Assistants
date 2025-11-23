class Solution:
    def kWeakestRows(self, mat: List[List[int]], k: int) -> List[int]:
        strength = []
        for i, row in enumerate(mat):
            strength.append((sum(row), i))
        strength.sort()
        return [i for (_, i) in strength[:k]]
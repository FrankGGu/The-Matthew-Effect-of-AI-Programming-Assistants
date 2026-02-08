class Solution:
    def kWeakestRows(self, mat: List[List[int]], k: int) -> List[int]:
        return [idx for idx, _ in sorted(enumerate(mat), key=lambda x: (sum(x[1]), x[0]))[:k]]
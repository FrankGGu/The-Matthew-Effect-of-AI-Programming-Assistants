class Solution:
    def countHiddenSequences(self, n: int, m: int, x: List[int], y: List[int]) -> int:
        total = 0
        for i in range(n):
            for j in range(m):
                if x[i] < y[j]:
                    total += 1
        return total
class Solution:
    def minCost(self, A: List[int], x: int) -> int:
        n = len(A)
        A.sort()
        total_cost = 0

        for i in range(n):
            total_cost += A[i] * (i + 1)

        return total_cost + (n * (n + 1) // 2 - n) * x
class Solution:
    def maximumImportance(self, n: int, roads: list[list[int]]) -> int:
        degrees = [0] * n

        for u, v in roads:
            degrees[u] += 1
            degrees[v] += 1

        degrees.sort()

        total_importance = 0
        for i in range(n):
            total_importance += degrees[i] * (i + 1)

        return total_importance
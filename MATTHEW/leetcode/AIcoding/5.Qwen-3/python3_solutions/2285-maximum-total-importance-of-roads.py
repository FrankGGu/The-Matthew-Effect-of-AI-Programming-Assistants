class Solution:
    def maximumImportance(self, n: int, roads: List[List[int]]) -> int:
        import collections
        degree = [0] * n
        for a, b in roads:
            degree[a] += 1
            degree[b] += 1
        degree.sort()
        return sum((i + 1) * d for i, d in enumerate(degree))
class Solution:
    def addEdges(self, edges: List[List[int]]) -> int:
        degree = [0] * 100001
        for u, v in edges:
            degree[u] += 1
            degree[v] += 1

        odd_count = sum(1 for d in degree if d % 2 == 1)

        return odd_count // 2
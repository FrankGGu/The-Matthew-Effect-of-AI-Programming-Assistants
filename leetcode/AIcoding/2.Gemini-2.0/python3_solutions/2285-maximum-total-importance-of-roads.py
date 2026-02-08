class Solution:
    def maximumImportance(self, n: int, roads: List[List[int]]) -> int:
        degrees = [0] * n
        for u, v in roads:
            degrees[u] += 1
            degrees[v] += 1

        importance = [0] * n
        sorted_nodes = sorted(range(n), key=lambda x: degrees[x], reverse=True)

        for i, node in enumerate(sorted_nodes):
            importance[node] = n - i

        total_importance = 0
        for u, v in roads:
            total_importance += importance[u] + importance[v]

        return total_importance
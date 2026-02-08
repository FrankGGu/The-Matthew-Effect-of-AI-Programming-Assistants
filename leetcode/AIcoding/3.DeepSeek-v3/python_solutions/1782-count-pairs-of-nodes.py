class Solution:
    def countPairs(self, n: int, edges: List[List[int]], queries: List[int]) -> List[int]:
        degree = [0] * (n + 1)
        edge_count = {}

        for u, v in edges:
            if u > v:
                u, v = v, u
            degree[u] += 1
            degree[v] += 1
            edge_count[(u, v)] = edge_count.get((u, v), 0) + 1

        sorted_degree = sorted(degree[1:])
        res = []

        for q in queries:
            total = 0
            left, right = 1, n
            while left < right:
                if sorted_degree[left - 1] + sorted_degree[right - 1] > q:
                    total += right - left
                    right -= 1
                else:
                    left += 1

            for (u, v), cnt in edge_count.items():
                if degree[u] + degree[v] > q and degree[u] + degree[v] - cnt <= q:
                    total -= 1

            res.append(total)

        return res
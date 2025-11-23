from collections import defaultdict

class Solution:
    def countPairs(self, n: int, edges: list[list[int]], queries: list[int]) -> list[int]:
        adj = defaultdict(int)
        degree = [0] * (n + 1)
        for u, v in edges:
            if u > v:
                u, v = v, u
            adj[(u, v)] += 1
            degree[u] += 1
            degree[v] += 1

        sorted_degree = sorted(degree[1:])

        result = []
        for query in queries:
            count = 0
            l, r = 0, n - 1
            while l < n:
                if sorted_degree[l] + sorted_degree[r] > query:
                    count += (r - l)
                    r -= 1
                else:
                    l += 1

            for (u, v), freq in adj.items():
                if degree[u] + degree[v] > query and degree[u] + degree[v] - freq <= query:
                    count -= 1

            result.append(count)

        return result
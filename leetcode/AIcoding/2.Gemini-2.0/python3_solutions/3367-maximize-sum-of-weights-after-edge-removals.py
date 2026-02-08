class Solution:
    def maxWeightSum(self, edges: list[list[int]], values: list[int], k: int) -> int:
        n = len(values)
        adj = [[] for _ in range(n)]
        degree = [0] * n
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            degree[u] += 1
            degree[v] += 1

        q = []
        for i in range(n):
            if degree[i] == 1:
                q.append(i)

        removed = 0
        while removed < k:
            if not q:
                break
            u = q.pop(0)
            if degree[u] == 1:
                removed += 1
                degree[u] = 0
                for v in adj[u]:
                    if degree[v] > 0:
                        degree[v] -= 1
                        if degree[v] == 1:
                            q.append(v)

        ans = 0
        for i in range(n):
            if degree[i] > 0:
                ans += values[i]

        return ans
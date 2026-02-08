import heapq

class Solution:
    def minScore(self, n: int, roads: List[List[int]]) -> int:
        adj = [[] for _ in range(n + 1)]
        for u, v, w in roads:
            adj[u].append((v, w))
            adj[v].append((u, w))

        min_score = float('inf')
        visited = [False] * (n + 1)
        queue = [1]
        visited[1] = True

        while queue:
            u = queue.pop(0)
            for v, w in adj[u]:
                min_score = min(min_score, w)
                if not visited[v]:
                    visited[v] = True
                    queue.append(v)

        return min_score
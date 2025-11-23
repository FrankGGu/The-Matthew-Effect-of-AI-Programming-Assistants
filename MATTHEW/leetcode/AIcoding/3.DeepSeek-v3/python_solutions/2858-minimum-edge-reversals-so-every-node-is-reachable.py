class Solution:
    def minEdgeReversals(self, n: int, edges: List[List[int]]) -> int:
        from collections import deque

        adj = [[] for _ in range(n)]
        reverse_adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            reverse_adj[v].append(u)

        # BFS to compute initial count
        root = 0
        res = [0] * n
        visited = [False] * n
        q = deque([root])
        visited[root] = True
        count = 0

        while q:
            u = q.popleft()
            for v in adj[u]:
                if not visited[v]:
                    visited[v] = True
                    q.append(v)
            for v in reverse_adj[u]:
                if not visited[v]:
                    visited[v] = True
                    q.append(v)
                    count += 1

        res[root] = count

        # BFS to compute for all nodes
        q = deque([root])
        visited = [False] * n
        visited[root] = True

        while q:
            u = q.popleft()
            for v in adj[u]:
                if not visited[v]:
                    res[v] = res[u] + 1
                    visited[v] = True
                    q.append(v)
            for v in reverse_adj[u]:
                if not visited[v]:
                    res[v] = res[u] - 1
                    visited[v] = True
                    q.append(v)

        return min(res)
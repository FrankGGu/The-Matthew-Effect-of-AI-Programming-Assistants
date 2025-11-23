from collections import defaultdict, deque

class Solution:
    def longestSpecialPath(self, n: int, edges: list[list[int]]) -> int:
        adj = defaultdict(list)
        in_degree = [0] * n

        for u, v in edges:
            adj[u].append(v)
            in_degree[v] += 1

        q = deque()
        dist = [0] * n

        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)

        max_path_length = 0

        while q:
            u = q.popleft()
            max_path_length = max(max_path_length, dist[u])

            for v in adj[u]:
                dist[v] = max(dist[v], dist[u] + 1)
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        return max_path_length
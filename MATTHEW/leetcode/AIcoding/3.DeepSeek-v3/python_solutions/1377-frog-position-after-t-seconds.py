class Solution:
    def frogPosition(self, n: int, edges: List[List[int]], t: int, target: int) -> float:
        from collections import deque

        if n == 1:
            return 1.0

        graph = [[] for _ in range(n + 1)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * (n + 1)
        q = deque()
        q.append((1, 1.0, 0))
        visited[1] = True

        while q:
            node, prob, time = q.popleft()
            if time > t:
                continue
            count = 0
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    count += 1
            if node == target:
                if time == t or (time < t and count == 0):
                    return prob
                else:
                    return 0.0
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    q.append((neighbor, prob / count, time + 1))

        return 0.0
from collections import deque

class Solution:
    def minStepsToTransfer(self, n: int, edges: list[list[int]], start_node: int, end_node: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        q = deque([(start_node, 0)])
        visited = {start_node}

        while q:
            curr, dist = q.popleft()
            if curr == end_node:
                return dist

            for neighbor in adj[curr]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    q.append((neighbor, dist + 1))

        return -1
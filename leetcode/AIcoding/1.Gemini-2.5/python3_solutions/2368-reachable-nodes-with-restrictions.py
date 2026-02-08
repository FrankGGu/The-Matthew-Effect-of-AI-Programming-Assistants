from collections import deque

class Solution:
    def reachableNodes(self, n: int, edges: list[list[int]], restricted: list[int]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        restricted_set = set(restricted)

        if 0 in restricted_set:
            return 0

        q = deque([0])
        visited = {0}
        reachable_count = 0

        while q:
            node = q.popleft()
            reachable_count += 1

            for neighbor in adj[node]:
                if neighbor not in restricted_set and neighbor not in visited:
                    visited.add(neighbor)
                    q.append(neighbor)

        return reachable_count
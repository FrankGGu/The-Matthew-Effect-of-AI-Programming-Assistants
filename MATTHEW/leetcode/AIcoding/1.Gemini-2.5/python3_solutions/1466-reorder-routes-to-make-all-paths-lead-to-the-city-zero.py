from collections import defaultdict, deque

class Solution:
    def minReorder(self, n: int, connections: list[list[int]]) -> int:
        adj = defaultdict(list)
        for u, v in connections:
            adj[u].append((v, 1))  # (neighbor, is_original_direction_u_to_v)
            adj[v].append((u, 0))  # (neighbor, is_reversed_direction_v_to_u)

        reorders = 0
        visited = [False] * n

        q = deque()
        q.append(0)
        visited[0] = True

        while q:
            u = q.popleft()

            for v, is_original_direction in adj[u]:
                if not visited[v]:
                    if is_original_direction == 1:
                        reorders += 1
                    visited[v] = True
                    q.append(v)

        return reorders
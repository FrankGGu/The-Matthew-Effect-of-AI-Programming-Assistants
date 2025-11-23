from collections import deque

class Solution:
    def countPairs(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visited = [False] * n
        component_sizes = []

        for i in range(n):
            if not visited[i]:
                q = deque()
                q.append(i)
                visited[i] = True
                current_component_size = 0

                while q:
                    node = q.popleft()
                    current_component_size += 1

                    for neighbor in adj[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            q.append(neighbor)

                component_sizes.append(current_component_size)

        total_unreachable_pairs = 0
        nodes_processed_so_far = 0

        for size in component_sizes:
            total_unreachable_pairs += size * (n - nodes_processed_so_far - size)
            nodes_processed_so_far += size

        return total_unreachable_pairs
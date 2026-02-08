from collections import deque

class Solution:
    def findMinHeightTrees(self, n: int, edges: list[list[int]]) -> list[int]:
        if n == 1:
            return [0]

        adj = [[] for _ in range(n)]
        degree = [0] * n

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            degree[u] += 1
            degree[v] += 1

        leaves = deque()
        for i in range(n):
            if degree[i] == 1:
                leaves.append(i)

        remaining_nodes = n
        while remaining_nodes > 2:
            num_leaves_in_current_layer = len(leaves)
            remaining_nodes -= num_leaves_in_current_layer

            for _ in range(num_leaves_in_current_layer):
                leaf = leaves.popleft()
                for neighbor in adj[leaf]:
                    degree[neighbor] -= 1
                    if degree[neighbor] == 1:
                        leaves.append(neighbor)

        return list(leaves)
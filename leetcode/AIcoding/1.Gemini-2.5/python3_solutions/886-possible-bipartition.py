import collections

class Solution:
    def possibleBipartition(self, n: int, dislikes: list[list[int]]) -> bool:
        adj = collections.defaultdict(list)
        for u, v in dislikes:
            adj[u].append(v)
            adj[v].append(u)

        colors = [0] * (n + 1)  # 0: uncolored, 1: color A, -1: color B

        for i in range(1, n + 1):
            if colors[i] == 0:  # If node i is uncolored, start BFS
                queue = collections.deque()
                queue.append(i)
                colors[i] = 1  # Assign initial color A

                while queue:
                    u = queue.popleft()
                    for v in adj[u]:
                        if colors[v] == 0:  # If neighbor v is uncolored
                            colors[v] = -colors[u]  # Assign opposite color
                            queue.append(v)
                        elif colors[v] == colors[u]:  # If neighbor v has the same color
                            return False  # Conflict detected, not bipartitionable

        return True  # No conflicts found, graph is bipartitionable
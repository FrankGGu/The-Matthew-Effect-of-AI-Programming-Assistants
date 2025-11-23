import collections

class Solution:
    def isBipartite(self, graph: List[List[int]]) -> bool:
        n = len(graph)
        colors = [-1] * n  # -1: uncolored, 0: color A, 1: color B

        for i in range(n):
            if colors[i] == -1:  # Node i is uncolored, start BFS from here
                q = collections.deque()
                q.append(i)
                colors[i] = 0  # Assign initial color to node i

                while q:
                    u = q.popleft()

                    for v in graph[u]:  # For each neighbor v of u
                        if colors[v] == -1:  # Neighbor v is uncolored
                            colors[v] = 1 - colors[u]  # Assign opposite color
                            q.append(v)
                        elif colors[v] == colors[u]:  # Neighbor v has same color as u
                            return False  # Not bipartite

        return True  # All nodes processed, no conflicts found
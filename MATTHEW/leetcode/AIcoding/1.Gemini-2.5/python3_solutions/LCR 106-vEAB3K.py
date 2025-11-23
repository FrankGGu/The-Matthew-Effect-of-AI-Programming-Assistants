from collections import deque

class Solution:
    def isBipartite(self, graph: list[list[int]]) -> bool:
        n = len(graph)
        colors = [-1] * n

        for i in range(n):
            if colors[i] == -1:
                q = deque()
                q.append(i)
                colors[i] = 0

                while q:
                    u = q.popleft()
                    current_color = colors[u]

                    for v in graph[u]:
                        if colors[v] == -1:
                            colors[v] = 1 - current_color
                            q.append(v)
                        elif colors[v] == current_color:
                            return False

        return True
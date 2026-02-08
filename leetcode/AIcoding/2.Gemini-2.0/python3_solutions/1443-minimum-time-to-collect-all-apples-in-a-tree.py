from collections import defaultdict

class Solution:
    def minTime(self, n: int, edges: list[list[int]], hasApple: list[bool]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            time = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    child_time = dfs(neighbor, node)
                    if child_time > 0 or hasApple[neighbor]:
                        time += child_time + 2
            return time

        return dfs(0, -1)
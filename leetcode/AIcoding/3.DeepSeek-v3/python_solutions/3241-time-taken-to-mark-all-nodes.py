import collections

class Solution:
    def minimumTime(self, n: int, edges: List[List[int]], hasApple: List[bool]) -> int:
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()

        def dfs(node):
            visited.add(node)
            total_time = 0
            for neighbor in graph[node]:
                if neighbor not in visited:
                    time = dfs(neighbor)
                    if time > 0 or hasApple[neighbor]:
                        total_time += time + 2
            return total_time

        return dfs(0)
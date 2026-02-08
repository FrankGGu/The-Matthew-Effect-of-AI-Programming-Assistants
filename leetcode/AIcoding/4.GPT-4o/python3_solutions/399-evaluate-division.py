from collections import defaultdict
import sys

class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        graph = defaultdict(dict)

        for (a, b), value in zip(equations, values):
            graph[a][b] = value
            graph[b][a] = 1 / value

        def dfs(start, end, visited):
            if start not in graph or end not in graph:
                return -1.0
            if start == end:
                return 1.0
            visited.add(start)
            for neighbor, value in graph[start].items():
                if neighbor not in visited:
                    product = dfs(neighbor, end, visited)
                    if product != -1.0:
                        return value * product
            visited.remove(start)
            return -1.0

        result = []
        for a, b in queries:
            result.append(dfs(a, b, set()))

        return result
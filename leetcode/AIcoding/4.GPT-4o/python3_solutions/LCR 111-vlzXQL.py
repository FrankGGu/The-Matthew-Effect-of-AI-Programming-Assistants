class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        graph = defaultdict(dict)

        for (x, y), value in zip(equations, values):
            graph[x][y] = value
            graph[y][x] = 1 / value

        def dfs(start, end, visited):
            if start not in graph or end not in graph:
                return -1.0
            if start == end:
                return 1.0
            visited.add(start)
            for neighbor, value in graph[start].items():
                if neighbor in visited:
                    continue
                result = dfs(neighbor, end, visited)
                if result != -1.0:
                    return result * value
            visited.remove(start)
            return -1.0

        results = []
        for x, y in queries:
            results.append(dfs(x, y, set()))

        return results
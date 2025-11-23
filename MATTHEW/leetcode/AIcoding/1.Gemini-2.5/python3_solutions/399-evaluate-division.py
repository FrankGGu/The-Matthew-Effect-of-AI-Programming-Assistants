from collections import defaultdict

class Solution:
    def calcEquation(self, equations: list[list[str]], values: list[float], queries: list[list[str]]) -> list[float]:
        graph = defaultdict(dict)

        for (a, b), val in zip(equations, values):
            graph[a][b] = val
            graph[b][a] = 1 / val

        results = []

        def dfs(start_node, end_node, current_product, visited):
            if start_node == end_node:
                return current_product

            visited.add(start_node)

            for neighbor, value in graph[start_node].items():
                if neighbor not in visited:
                    res = dfs(neighbor, end_node, current_product * value, visited)
                    if res != -1.0:
                        return res

            return -1.0

        for query_start, query_end in queries:
            if query_start not in graph or query_end not in graph:
                results.append(-1.0)
            elif query_start == query_end:
                results.append(1.0)
            else:
                visited = set()
                results.append(dfs(query_start, query_end, 1.0, visited))

        return results
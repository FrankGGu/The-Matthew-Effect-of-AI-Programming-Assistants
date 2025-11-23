class Graph:
    def __init__(self, n):
        self.graph = [[] for _ in range(n)]

    def add_edge(self, u, v):
        self.graph[u].append(v)
        self.graph[v].append(u)

class Solution:
    def pathExists(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[bool]:
        graph = Graph(n)
        for u, v in edges:
            graph.add_edge(u, v)

        def dfs(node, target, visited):
            if node == target:
                return True
            visited.add(node)
            for neighbor in graph.graph[node]:
                if neighbor not in visited and dfs(neighbor, target, visited):
                    return True
            return False

        result = []
        for u, v in queries:
            visited = set()
            result.append(dfs(u, v, visited))

        return result
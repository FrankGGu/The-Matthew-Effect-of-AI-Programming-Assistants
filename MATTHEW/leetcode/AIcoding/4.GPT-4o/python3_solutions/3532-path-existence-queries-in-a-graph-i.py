class Graph:
    def __init__(self, n: int):
        self.graph = [[] for _ in range(n)]

    def add_edge(self, u: int, v: int) -> None:
        self.graph[u].append(v)
        self.graph[v].append(u)

class Solution:
    def __init__(self, n: int, edges: List[List[int]]):
        self.graph = Graph(n)
        for u, v in edges:
            self.graph.add_edge(u, v)
        self.visited = [False] * n

    def dfs(self, node: int) -> None:
        self.visited[node] = True
        for neighbor in self.graph.graph[node]:
            if not self.visited[neighbor]:
                self.dfs(neighbor)

    def path_exists(self, start: int, end: int) -> bool:
        self.visited = [False] * len(self.graph.graph)
        self.dfs(start)
        return self.visited[end]
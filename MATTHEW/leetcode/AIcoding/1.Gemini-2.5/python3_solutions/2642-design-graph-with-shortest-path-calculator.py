import collections
import heapq

class Graph:

    def __init__(self, n: int, edges: list[list[int]]):
        self.graph = collections.defaultdict(dict)
        self.n = n
        for u, v, cost in edges:
            self.graph[u][v] = cost

    def addEdge(self, edge: list[int]) -> None:
        u, v, cost = edge
        self.graph[u][v] = cost

    def shortestPath(self, node1: int, node2: int) -> int:
        distances = {i: float('inf') for i in range(self.n)}
        distances[node1] = 0

        priority_queue = [(0, node1)] # (cost, node)

        while priority_queue:
            current_cost, u = heapq.heappop(priority_queue)

            if current_cost > distances[u]:
                continue

            if u == node2:
                return current_cost

            for v, weight in self.graph[u].items():
                if distances[u] + weight < distances[v]:
                    distances[v] = distances[u] + weight
                    heapq.heappush(priority_queue, (distances[v], v))

        return -1
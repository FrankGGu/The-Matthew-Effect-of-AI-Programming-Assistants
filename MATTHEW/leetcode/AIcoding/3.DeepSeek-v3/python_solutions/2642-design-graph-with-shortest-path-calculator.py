import heapq

class Graph:

    def __init__(self, n: int, edges: List[List[int]]):
        self.n = n
        self.graph = [[] for _ in range(n)]
        for u, v, cost in edges:
            self.graph[u].append((v, cost))

    def addEdge(self, edge: List[int]) -> None:
        u, v, cost = edge
        self.graph[u].append((v, cost))

    def shortestPath(self, node1: int, node2: int) -> int:
        heap = [(0, node1)]
        dist = [float('inf')] * self.n
        dist[node1] = 0

        while heap:
            current_dist, u = heapq.heappop(heap)
            if u == node2:
                return current_dist
            if current_dist > dist[u]:
                continue
            for v, cost in self.graph[u]:
                if dist[v] > current_dist + cost:
                    dist[v] = current_dist + cost
                    heapq.heappush(heap, (dist[v], v))
        return -1
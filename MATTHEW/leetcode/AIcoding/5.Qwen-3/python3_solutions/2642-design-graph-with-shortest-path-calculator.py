from collections import defaultdict, deque

class Graph:
    def __init__(self, n: int, edges: List[List[int]]):
        self.n = n
        self.graph = defaultdict(list)
        for edge in edges:
            self.graph[edge[0]].append((edge[1], edge[2]))

    def addEdge(self, edge: List[int]) -> None:
        self.graph[edge[0]].append((edge[1], edge[2]))

    def shortestPath(self, node1: int, node2: int) -> int:
        dist = [float('inf')] * self.n
        dist[node1] = 0
        pq = [(0, node1)]

        while pq:
            d, u = heapq.heappop(pq)
            if u == node2:
                return d
            if d > dist[u]:
                continue
            for v, w in self.graph[u]:
                if dist[v] > d + w:
                    dist[v] = d + w
                    heapq.heappush(pq, (dist[v], v))

        return -1
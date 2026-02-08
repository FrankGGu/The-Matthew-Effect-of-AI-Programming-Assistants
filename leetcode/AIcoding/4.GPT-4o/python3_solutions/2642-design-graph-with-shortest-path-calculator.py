import heapq
from collections import defaultdict

class Graph:
    def __init__(self):
        self.graph = defaultdict(list)

    def addEdge(self, u: int, v: int, w: int) -> None:
        self.graph[u].append((v, w))
        self.graph[v].append((u, w))

    def shortestPath(self, start: int, end: int) -> int:
        min_heap = [(0, start)]
        distances = {start: 0}

        while min_heap:
            curr_distance, curr_node = heapq.heappop(min_heap)
            if curr_node == end:
                return curr_distance
            for neighbor, weight in self.graph[curr_node]:
                distance = curr_distance + weight
                if neighbor not in distances or distance < distances[neighbor]:
                    distances[neighbor] = distance
                    heapq.heappush(min_heap, (distance, neighbor))
        return -1
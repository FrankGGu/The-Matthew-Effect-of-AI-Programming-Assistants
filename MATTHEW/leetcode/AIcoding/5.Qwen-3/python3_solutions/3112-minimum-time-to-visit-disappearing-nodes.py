from typing import List
import heapq

class Solution:
    def minimumTimeToVisitDisappearingNodes(self, edges: List[List[int]], nodeTime: List[int], maxTime: int) -> int:
        graph = [[] for _ in range(len(nodeTime))]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dist = [-1] * len(nodeTime)
        heap = [(0, 0)]

        while heap:
            time, node = heapq.heappop(heap)
            if dist[node] != -1:
                continue
            dist[node] = time
            for neighbor in graph[node]:
                if dist[neighbor] == -1 and time + 1 <= maxTime:
                    heapq.heappush(heap, (time + 1, neighbor))

        return sum(nodeTime[i] for i in range(len(nodeTime)) if dist[i] != -1)
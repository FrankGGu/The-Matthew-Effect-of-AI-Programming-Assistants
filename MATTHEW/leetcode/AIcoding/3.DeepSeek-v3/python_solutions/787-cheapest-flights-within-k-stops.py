import heapq

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        graph = [[] for _ in range(n)]
        for u, v, w in flights:
            graph[u].append((v, w))

        heap = []
        heapq.heappush(heap, (0, src, k + 1))

        while heap:
            cost, node, stops = heapq.heappop(heap)
            if node == dst:
                return cost
            if stops > 0:
                for neighbor, price in graph[node]:
                    heapq.heappush(heap, (cost + price, neighbor, stops - 1))

        return -1
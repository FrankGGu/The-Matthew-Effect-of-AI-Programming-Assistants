import heapq

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        graph = defaultdict(list)
        for u, v, w in flights:
            graph[u].append((v, w))

        heap = [(0, src, 0)]
        while heap:
            price, city, stops = heapq.heappop(heap)
            if city == dst:
                return price
            if stops <= k:
                for neighbor, cost in graph[city]:
                    heapq.heappush(heap, (price + cost, neighbor, stops + 1))

        return -1
import heapq

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        graph = defaultdict(list)
        for u, v, w in flights:
            graph[u].append((v, w))

        pq = [(0, src, k + 1)]
        dist = {}

        while pq:
            cost, city, stops = heapq.heappop(pq)

            if city == dst:
                return cost

            if stops > 0:
                for neighbor, price in graph[city]:
                    new_cost = cost + price
                    if (neighbor, stops - 1) not in dist or new_cost < dist[(neighbor, stops - 1)]:
                        dist[(neighbor, stops - 1)] = new_cost
                        heapq.heappush(pq, (new_cost, neighbor, stops - 1))

        return -1
class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        import collections
        graph = collections.defaultdict(list)
        for s, d, p in flights:
            graph[s].append((d, p))

        queue = collections.deque()
        queue.append((src, 0))
        min_cost = [float('inf')] * n
        min_cost[src] = 0

        stops = 0
        while queue and stops <= k:
            for _ in range(len(queue)):
                node, cost = queue.popleft()
                for neighbor, price in graph[node]:
                    if cost + price < min_cost[neighbor]:
                        min_cost[neighbor] = cost + price
                        queue.append((neighbor, min_cost[neighbor]))
            stops += 1

        return min_cost[dst] if min_cost[dst] != float('inf') else -1
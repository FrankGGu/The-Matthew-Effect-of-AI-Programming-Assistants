class Solution:
    def minCostArrayPermutation(self, cost: List[int]) -> int:
        from collections import defaultdict
        import heapq

        n = len(cost)
        graph = defaultdict(list)
        for i in range(n):
            graph[i].append((i + 1, cost[i]))
            graph[i].append((i - 1, cost[i]))

        dist = [float('inf')] * n
        dist[0] = 0
        heap = [(0, 0)]

        while heap:
            d, u = heapq.heappop(heap)
            if d > dist[u]:
                continue
            for v, w in graph[u]:
                if dist[v] > d + w:
                    dist[v] = d + w
                    heapq.heappush(heap, (dist[v], v))

        return dist[-1]
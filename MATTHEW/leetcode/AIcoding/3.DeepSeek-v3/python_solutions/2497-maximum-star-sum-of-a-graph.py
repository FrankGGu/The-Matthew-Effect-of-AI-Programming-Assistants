import heapq

class Solution:
    def maxStarSum(self, vals: List[int], edges: List[List[int]], k: int) -> int:
        n = len(vals)
        graph = [[] for _ in range(n)]

        for u, v in edges:
            if vals[v] > 0:
                heapq.heappush(graph[u], vals[v])
                if len(graph[u]) > k:
                    heapq.heappop(graph[u])
            if vals[u] > 0:
                heapq.heappush(graph[v], vals[u])
                if len(graph[v]) > k:
                    heapq.heappop(graph[v])

        max_sum = -float('inf')
        for i in range(n):
            total = vals[i] + sum(graph[i])
            if total > max_sum:
                max_sum = total

        return max_sum
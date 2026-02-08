import collections
import heapq

class Solution:
    def maxStarSum(self, vals: list[int], edges: list[list[int]], k: int) -> int:
        n = len(vals)
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        max_star_sum = float('-inf')

        for i in range(n):
            current_star_sum = vals[i]

            min_heap = []
            for neighbor_node in adj[i]:
                if vals[neighbor_node] > 0:
                    if len(min_heap) < k:
                        heapq.heappush(min_heap, vals[neighbor_node])
                    elif vals[neighbor_node] > min_heap[0]:
                        heapq.heappop(min_heap)
                        heapq.heappush(min_heap, vals[neighbor_node])

            for val in min_heap:
                current_star_sum += val

            max_star_sum = max(max_star_sum, current_star_sum)

        return max_star_sum
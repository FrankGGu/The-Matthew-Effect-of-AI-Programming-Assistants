import collections
import heapq

class Solution:
    def maxProbability(self, n: int, edges: list[list[int]], succProb: list[float], start: int, end: int) -> float:
        adj = collections.defaultdict(list)
        for i in range(len(edges)):
            u, v = edges[i]
            p = succProb[i]
            adj[u].append((v, p))
            adj[v].append((u, p))

        prob = [0.0] * n
        prob[start] = 1.0

        pq = [(-1.0, start)]  # Max-heap using negative probabilities

        while pq:
            current_prob, u = heapq.heappop(pq)
            current_prob = -current_prob  # Convert back to positive probability

            if current_prob < prob[u]:
                continue

            for v, edge_prob in adj[u]:
                new_prob = current_prob * edge_prob
                if new_prob > prob[v]:
                    prob[v] = new_prob
                    heapq.heappush(pq, (-new_prob, v))

        return prob[end]
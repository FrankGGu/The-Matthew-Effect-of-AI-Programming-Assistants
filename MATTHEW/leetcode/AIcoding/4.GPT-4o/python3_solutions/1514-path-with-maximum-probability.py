import heapq
from collections import defaultdict

class Solution:
    def maxProbability(self, n: int, edges: List[List[int]], succProb: List[float], start: int, end: int) -> float:
        graph = defaultdict(list)
        for (u, v), prob in zip(edges, succProb):
            graph[u].append((v, prob))
            graph[v].append((u, prob))

        max_prob = [0] * n
        max_prob[start] = 1
        pq = [(-1, start)]

        while pq:
            curr_prob, node = heapq.heappop(pq)
            curr_prob = -curr_prob

            if node == end:
                return curr_prob

            for neighbor, prob in graph[node]:
                new_prob = curr_prob * prob
                if new_prob > max_prob[neighbor]:
                    max_prob[neighbor] = new_prob
                    heapq.heappush(pq, (-new_prob, neighbor))

        return 0.0
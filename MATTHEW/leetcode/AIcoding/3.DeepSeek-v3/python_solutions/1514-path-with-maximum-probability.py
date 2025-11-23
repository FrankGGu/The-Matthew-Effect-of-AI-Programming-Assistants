import heapq

class Solution:
    def maxProbability(self, n: int, edges: List[List[int]], succProb: List[float], start: int, end: int) -> float:
        graph = [[] for _ in range(n)]
        for i, (u, v) in enumerate(edges):
            graph[u].append((v, succProb[i]))
            graph[v].append((u, succProb[i]))

        max_prob = [0.0] * n
        max_prob[start] = 1.0

        heap = [(-1.0, start)]

        while heap:
            current_prob, u = heapq.heappop(heap)
            current_prob = -current_prob

            if u == end:
                return current_prob

            if current_prob < max_prob[u]:
                continue

            for v, prob in graph[u]:
                next_prob = current_prob * prob
                if next_prob > max_prob[v]:
                    max_prob[v] = next_prob
                    heapq.heappush(heap, (-next_prob, v))

        return 0.0
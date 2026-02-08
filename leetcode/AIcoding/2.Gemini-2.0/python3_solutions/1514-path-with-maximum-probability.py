import heapq

class Solution:
    def maxProbability(self, n: int, edges: List[List[int]], succProb: List[float], start: int, end: int) -> float:
        graph = [[] for _ in range(n)]
        for i, (u, v) in enumerate(edges):
            graph[u].append((v, succProb[i]))
            graph[v].append((u, succProb[i]))

        probs = [0.0] * n
        probs[start] = 1.0
        pq = [(-1.0, start)]

        while pq:
            prob, node = heapq.heappop(pq)
            prob = -prob

            if prob < probs[node]:
                continue

            for neighbor, edge_prob in graph[node]:
                new_prob = prob * edge_prob
                if new_prob > probs[neighbor]:
                    probs[neighbor] = new_prob
                    heapq.heappush(pq, (-new_prob, neighbor))

        return probs[end]
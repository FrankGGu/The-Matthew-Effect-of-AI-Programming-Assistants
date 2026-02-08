import collections
import heapq

class Solution:
    def maximumScore(self, scores: list[int], edges: list[list[int]]) -> int:
        n = len(scores)

        adj_raw = collections.defaultdict(list)
        for u, v in edges:
            adj_raw[u].append((scores[v], v))
            adj_raw[v].append((scores[u], u))

        adj = collections.defaultdict(list)
        for u in range(n):
            adj[u] = heapq.nlargest(3, adj_raw[u], key=lambda x: x[0])

        max_total_score = -1

        for u, v in edges:
            for score_a, a_node in adj[u]:
                if a_node == v:
                    continue

                for score_d, d_node in adj[v]:
                    if d_node == u:
                        continue
                    if d_node == a_node:
                        continue

                    current_score = scores[a_node] + scores[u] + scores[v] + scores[d_node]
                    max_total_score = max(max_total_score, current_score)

        return max_total_score
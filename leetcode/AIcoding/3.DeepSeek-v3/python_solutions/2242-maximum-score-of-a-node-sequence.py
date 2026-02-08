class Solution:
    def maximumScore(self, scores: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict
        graph = defaultdict(list)
        n = len(scores)
        for u, v in edges:
            graph[u].append((scores[v], v))
            graph[v].append((scores[u], u))

        for u in range(n):
            graph[u].sort(reverse=True)
            graph[u] = graph[u][:3]

        max_score = -1
        for u, v in edges:
            current_score = scores[u] + scores[v]
            for (score_a, a) in graph[u]:
                if a == v:
                    continue
                for (score_b, b) in graph[v]:
                    if b == u or b == a:
                        continue
                    total = current_score + score_a + score_b
                    if total > max_score:
                        max_score = total
        return max_score
class Solution:
    def maximumScore(self, scores: List[int], edges: List[List[int]]) -> int:
        n = len(scores)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        for i in range(n):
            adj[i].sort(key=lambda x: scores[x], reverse=True)
            if len(adj[i]) > 3:
                adj[i] = adj[i][:3]

        max_score = -1
        for u, v in edges:
            for a in adj[u]:
                if a == v:
                    continue
                for b in adj[v]:
                    if b == u or b == a:
                        continue
                    max_score = max(max_score, scores[u] + scores[v] + scores[a] + scores[b])

        return max_score
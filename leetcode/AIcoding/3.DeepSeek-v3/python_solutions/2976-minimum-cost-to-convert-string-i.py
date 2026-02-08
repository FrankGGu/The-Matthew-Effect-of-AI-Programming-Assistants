class Solution:
    def minimumCost(self, source: str, target: str, original: List[str], changed: List[str], cost: List[int]) -> int:
        from collections import defaultdict
        import heapq

        # Build the graph
        graph = defaultdict(dict)
        nodes = set()
        for o, c, co in zip(original, changed, cost):
            nodes.add(o)
            nodes.add(c)
            if c in graph[o]:
                if co < graph[o][c]:
                    graph[o][c] = co
            else:
                graph[o][c] = co

        # Precompute all pairs shortest paths using Floyd-Warshall
        dist = {}
        for u in nodes:
            dist[u] = {}
            for v in nodes:
                if u == v:
                    dist[u][v] = 0
                elif v in graph[u]:
                    dist[u][v] = graph[u][v]
                else:
                    dist[u][v] = float('inf')

        for k in nodes:
            for i in nodes:
                for j in nodes:
                    if dist[i][j] > dist[i][k] + dist[k][j]:
                        dist[i][j] = dist[i][k] + dist[k][j]

        total_cost = 0
        for s_char, t_char in zip(source, target):
            if s_char == t_char:
                continue
            if s_char not in dist or t_char not in dist[s_char] or dist[s_char][t_char] == float('inf'):
                return -1
            total_cost += dist[s_char][t_char]

        return total_cost
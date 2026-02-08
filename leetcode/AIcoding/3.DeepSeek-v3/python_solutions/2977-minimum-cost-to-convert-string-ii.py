import heapq

class Solution:
    def minimumCost(self, source: str, target: str, original: List[str], changed: List[str], cost: List[int]) -> int:
        # Build a graph with all possible characters
        chars = set()
        for c in source + target:
            chars.add(c)
        for o, c in zip(original, changed):
            chars.update(o + c)
        char_list = list(chars)
        char_to_idx = {c: i for i, c in enumerate(char_list)}
        n = len(char_list)

        # Initialize distance matrix
        dist = [[float('inf')] * n for _ in range(n)]
        for i in range(n):
            dist[i][i] = 0
        for o, c, co in zip(original, changed, cost):
            u = char_to_idx[o]
            v = char_to_idx[c]
            if co < dist[u][v]:
                dist[u][v] = co

        # Floyd-Warshall to find all pairs shortest paths
        for k in range(n):
            for i in range(n):
                for j in range(n):
                    if dist[i][k] + dist[k][j] < dist[i][j]:
                        dist[i][j] = dist[i][k] + dist[k][j]

        total_cost = 0
        for s_char, t_char in zip(source, target):
            if s_char == t_char:
                continue
            u = char_to_idx[s_char]
            v = char_to_idx[t_char]
            if dist[u][v] == float('inf'):
                return -1
            total_cost += dist[u][v]

        return total_cost
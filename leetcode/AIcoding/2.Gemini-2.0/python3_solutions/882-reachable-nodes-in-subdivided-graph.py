import heapq

class Solution:
    def reachableNodes(self, edges: list[list[int]], maxMoves: int, n: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v, w in edges:
            adj[u].append((v, w))
            adj[v].append((u, w))

        dist = [float('inf')] * n
        dist[0] = 0
        pq = [(0, 0)]
        visited = set()
        ans = 0

        while pq:
            d, u = heapq.heappop(pq)

            if u in visited:
                continue
            visited.add(u)
            ans += 1

            for v, w in adj[u]:
                if d + w + 1 < dist[v] and d + w + 1 <= maxMoves:
                    dist[v] = d + w + 1
                    heapq.heappush(pq, (dist[v], v))

        used = {}
        for u, v, w in edges:
            a = max(0, maxMoves - dist[u])
            b = max(0, maxMoves - dist[v])
            ans += min(w, a + b)

        return ans
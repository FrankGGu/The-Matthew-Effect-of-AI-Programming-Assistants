class Solution:
    def minimumCost(self, source: str, target: str, originalChar: str, changedChar: str, cost: List[int]) -> int:
        import heapq

        graph = {}
        for i in range(26):
            graph[chr(ord('a') + i)] = {}

        for o, c, co in zip(originalChar, changedChar, cost):
            if c not in graph[o] or co < graph[o][c]:
                graph[o][c] = co

        def dijkstra(start):
            dist = {chr(ord('a') + i): float('inf') for i in range(26)}
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                current_dist, node = heapq.heappop(heap)
                if current_dist > dist[node]:
                    continue
                for neighbor, weight in graph[node].items():
                    if dist[neighbor] > current_dist + weight:
                        dist[neighbor] = current_dist + weight
                        heapq.heappush(heap, (dist[neighbor], neighbor))
            return dist

        total_cost = 0
        for s, t in zip(source, target):
            if s == t:
                continue
            dist = dijkstra(s)
            if dist[t] == float('inf'):
                return -1
            total_cost += dist[t]
        return total_cost
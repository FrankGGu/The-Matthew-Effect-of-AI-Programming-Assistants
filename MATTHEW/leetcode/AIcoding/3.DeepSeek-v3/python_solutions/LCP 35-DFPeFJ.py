import heapq

class Solution:
    def electricCarPlan(self, paths: List[List[int]], cnt: int, start: int, end: int, charge: List[int]) -> int:
        n = len(charge)
        adj = [[] for _ in range(n)]
        for u, v, w in paths:
            adj[u].append((v, w))
            adj[v].append((u, w))

        heap = []
        heapq.heappush(heap, (0, start, 0))
        visited = {}
        visited[(start, 0)] = 0

        while heap:
            time, u, power = heapq.heappop(heap)
            if u == end:
                return time
            if time > visited.get((u, power), float('inf')):
                continue
            # Charge
            if power < cnt:
                new_power = power + 1
                new_time = time + charge[u]
                if (u, new_power) not in visited or new_time < visited[(u, new_power)]:
                    visited[(u, new_power)] = new_time
                    heapq.heappush(heap, (new_time, u, new_power))
            # Move
            for v, w in adj[u]:
                if power >= w:
                    new_power = power - w
                    new_time = time + w
                    if (v, new_power) not in visited or new_time < visited[(v, new_power)]:
                        visited[(v, new_power)] = new_time
                        heapq.heappush(heap, (new_time, v, new_power))
        return -1
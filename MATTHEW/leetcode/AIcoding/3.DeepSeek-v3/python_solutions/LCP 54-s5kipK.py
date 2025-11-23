class Solution:
    def minimumTime(self, n: int, edges: List[List[int]], disappear: List[int]) -> List[int]:
        import heapq
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v, length in edges:
            graph[u].append((v, length))
            graph[v].append((u, length))

        heap = []
        heapq.heappush(heap, (0, 0))
        res = [-1] * n
        res[0] = 0

        while heap:
            current_time, node = heapq.heappop(heap)
            if current_time > res[node] and res[node] != -1:
                continue
            for neighbor, length in graph[node]:
                new_time = current_time + length
                if new_time < disappear[neighbor] and (res[neighbor] == -1 or new_time < res[neighbor]):
                    res[neighbor] = new_time
                    heapq.heappush(heap, (new_time, neighbor))

        return res
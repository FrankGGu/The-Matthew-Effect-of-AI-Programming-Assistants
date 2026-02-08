import heapq

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        graph = collections.defaultdict(list)
        for u, v, w in times:
            graph[u].append((v, w))

        heap = []
        heapq.heappush(heap, (0, k))
        visited = {}

        while heap:
            time, node = heapq.heappop(heap)
            if node not in visited:
                visited[node] = time
                for v, w in graph[node]:
                    if v not in visited:
                        heapq.heappush(heap, (time + w, v))

        if len(visited) == n:
            return max(visited.values())
        else:
            return -1
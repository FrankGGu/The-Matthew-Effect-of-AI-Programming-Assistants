from collections import deque

class Solution:
    def networkBecomesIdle(self, edges: list[list[int]], patience: list[int]) -> int:
        n = len(patience)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dist = [-1] * n
        dist[0] = 0
        queue = deque([0])

        while queue:
            u = queue.popleft()
            for v in graph[u]:
                if dist[v] == -1:
                    dist[v] = dist[u] + 1
                    queue.append(v)

        max_time = 0
        for i in range(1, n):
            travel_time = 2 * dist[i]
            last_send_time = (travel_time // patience[i]) * patience[i]
            if last_send_time == travel_time:
                last_send_time -= patience[i] if patience[i] != travel_time else 0
            max_time = max(max_time, last_send_time + travel_time)

        return max_time + 1
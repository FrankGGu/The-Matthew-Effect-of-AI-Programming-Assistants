import collections

class Solution:
    def networkBecomesIdle(self, edges: List[List[int]], patience: List[int]) -> int:
        n = len(patience)
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        distance = [0] * n
        visited = [False] * n
        q = collections.deque()
        q.append(0)
        visited[0] = True

        while q:
            node = q.popleft()
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    distance[neighbor] = distance[node] + 1
                    q.append(neighbor)

        max_time = 0
        for i in range(1, n):
            d = distance[i] * 2
            p = patience[i]
            if p >= d:
                total_time = d
            else:
                last_sent = (d - 1) // p * p
                total_time = last_sent + d
            max_time = max(max_time, total_time)

        return max_time + 1
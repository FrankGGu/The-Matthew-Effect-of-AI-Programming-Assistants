class Solution:
    def networkBecomesIdle(self, edges: List[List[int]], patience: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        n = len(patience)
        dist = [float('inf')] * n
        dist[0] = 0

        queue = deque([0])
        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if dist[neighbor] == float('inf'):
                    dist[neighbor] = dist[node] + 1
                    queue.append(neighbor)

        max_time = 0
        for i in range(1, n):
            time_to_return = dist[i] * 2
            if time_to_return > patience[i]:
                max_time = max(max_time, time_to_return + (time_to_return - patience[i]))
            else:
                max_time = max(max_time, time_to_return)

        return max_time + 1
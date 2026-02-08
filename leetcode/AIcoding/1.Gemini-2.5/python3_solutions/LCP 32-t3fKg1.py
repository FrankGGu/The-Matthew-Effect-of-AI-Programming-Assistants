from collections import defaultdict, deque

class Solution:
    def minimumTime(self, n: int, times: list[int], dependencies: list[list[int]]) -> int:
        adj = defaultdict(list)
        in_degree = [0] * n

        for u, v in dependencies:
            adj[u].append(v)
            in_degree[v] += 1

        earliest_start_time = [0] * n
        earliest_finish_time = [0] * n

        q = deque()

        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)
                earliest_finish_time[i] = times[i]

        while q:
            u = q.popleft()

            for v in adj[u]:
                earliest_start_time[v] = max(earliest_start_time[v], earliest_finish_time[u])

                in_degree[v] -= 1

                if in_degree[v] == 0:
                    earliest_finish_time[v] = earliest_start_time[v] + times[v]
                    q.append(v)

        return max(earliest_finish_time)
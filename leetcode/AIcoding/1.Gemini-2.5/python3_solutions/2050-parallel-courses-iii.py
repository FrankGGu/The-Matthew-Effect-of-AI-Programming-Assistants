import collections

class Solution:
    def minimumTime(self, n: int, relations: list[list[int]], time: list[int]) -> int:
        adj = [[] for _ in range(n + 1)]
        in_degree = [0] * (n + 1)

        for prev_course, next_course in relations:
            adj[prev_course].append(next_course)
            in_degree[next_course] += 1

        finish_time = [0] * (n + 1)
        q = collections.deque()

        for i in range(1, n + 1):
            if in_degree[i] == 0:
                finish_time[i] = time[i - 1]
                q.append(i)

        while q:
            u = q.popleft()

            for v in adj[u]:
                finish_time[v] = max(finish_time[v], finish_time[u])
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    finish_time[v] += time[v - 1]
                    q.append(v)

        return max(finish_time)
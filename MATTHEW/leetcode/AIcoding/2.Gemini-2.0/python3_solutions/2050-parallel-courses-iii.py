from collections import defaultdict, deque

class Solution:
    def minimumTime(self, n: int, relations: List[List[int]], time: List[int]) -> int:
        indegree = [0] * n
        graph = defaultdict(list)
        for prev, nxt in relations:
            graph[prev - 1].append(nxt - 1)
            indegree[nxt - 1] += 1

        dp = [0] * n
        queue = deque()
        for i in range(n):
            if indegree[i] == 0:
                queue.append(i)
                dp[i] = time[i]

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                dp[neighbor] = max(dp[neighbor], dp[node] + time[neighbor])
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        return max(dp)
from collections import defaultdict, deque

class Solution:
    def maximumProfit(self, n: int, edges: list[list[int]], amount: list[int]) -> int:
        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque([i for i in range(n) if in_degree[i] == 0])
        dp = [0] * n
        for i in range(n):
            dp[i] = amount[i]

        count = 0
        while queue:
            u = queue.popleft()
            count += 1
            for v in graph[u]:
                dp[v] += max(0, dp[u])
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    queue.append(v)

        if count != n:
            return -1

        return max(dp)
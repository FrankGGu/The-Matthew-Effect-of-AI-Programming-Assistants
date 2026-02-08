class Solution:
    def minimizeTotalPrice(self, n: int, edges: List[List[int]], price: List[int]) -> int:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dp = [[0, 0] for _ in range(n)]
        visited = [False] * n

        def dfs(node: int):
            visited[node] = True
            dp[node][1] = price[node]
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    dfs(neighbor)
                    dp[node][0] += min(dp[neighbor][0], dp[neighbor][1])
                    dp[node][1] += dp[neighbor][0]

        dfs(0)
        return min(dp[0][0], dp[0][1])
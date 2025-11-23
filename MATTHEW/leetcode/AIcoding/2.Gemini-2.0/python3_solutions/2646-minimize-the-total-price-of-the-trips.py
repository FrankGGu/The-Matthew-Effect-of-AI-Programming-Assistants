from collections import defaultdict

class Solution:
    def minimumTotalPrice(self, n: int, edges: list[list[int]], price: list[int], trips: list[list[int]]) -> int:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        count = [0] * n

        def dfs(node, target, path):
            if node == target:
                for n in path:
                    count[n] += 1
                return True

            for neighbor in adj[node]:
                if neighbor not in path:
                    if dfs(neighbor, target, path + [neighbor]):
                        return True
            return False

        for start, end in trips:
            dfs(start, end, [start])

        dp = [[0, 0] for _ in range(n)]

        def dfs2(node, parent):
            dp[node][0] = price[node] * count[node]
            dp[node][1] = price[node] * count[node] // 2

            for neighbor in adj[node]:
                if neighbor != parent:
                    dfs2(neighbor, node)
                    dp[node][0] += min(dp[neighbor][0], dp[neighbor][1])
                    dp[node][1] += dp[neighbor][0]

        dfs2(0, -1)
        return min(dp[0][0], dp[0][1])
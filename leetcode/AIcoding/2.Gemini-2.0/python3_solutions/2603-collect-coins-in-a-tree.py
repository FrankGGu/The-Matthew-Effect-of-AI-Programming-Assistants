class Solution:
    def collectTheCoins(self, coins: list[int], edges: list[list[int]]) -> int:
        n = len(coins)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        degrees = [len(adj[i]) for i in range(n)]

        remaining = n
        for _ in range(2):
            leaves = []
            for i in range(n):
                if degrees[i] == 1 and coins[i] == 0:
                    leaves.append(i)

            for leaf in leaves:
                if degrees[leaf] > 0:
                    remaining -= 1
                    degrees[leaf] = 0
                    for neighbor in adj[leaf]:
                        degrees[neighbor] -= 1

        leaves = []
        for i in range(n):
            if degrees[i] == 1 and coins[i] == 1:
                leaves.append(i)

        for leaf in leaves:
            if degrees[leaf] > 0:
                remaining -= 1
                degrees[leaf] = 0
                for neighbor in adj[leaf]:
                    degrees[neighbor] -= 1

        if remaining <= 0:
            return 0

        ans = 0
        for u, v in edges:
            if degrees[u] > 0 and degrees[v] > 0:
                ans += 1

        return ans * 2
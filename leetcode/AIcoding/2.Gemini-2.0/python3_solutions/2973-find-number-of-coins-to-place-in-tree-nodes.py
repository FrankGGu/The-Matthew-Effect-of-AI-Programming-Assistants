class Solution:
    def placedCoins(self, edges: list[list[int]], cost: list[int]) -> list[int]:
        n = len(cost)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = [0] * n

        def dfs(node, parent):
            pos = []
            neg = []

            for neighbor in adj[node]:
                if neighbor != parent:
                    p, n = dfs(neighbor, node)
                    pos.extend(p)
                    neg.extend(n)

            pos.append(cost[node])
            neg.append(cost[node])

            pos.sort(reverse=True)
            neg.sort()

            ans[node] = 0
            if len(pos) >= 3:
                ans[node] = max(ans[node], pos[0] * pos[1] * pos[2])
            if len(neg) >= 3:
                ans[node] = max(ans[node], neg[0] * neg[1] * neg[2])
            if len(pos) >= 2 and len(neg) >= 1:
                ans[node] = max(ans[node], pos[0] * pos[1] * neg[0])
            if len(neg) >= 2 and len(pos) >= 1:
                ans[node] = max(ans[node], neg[0] * neg[1] * pos[0])

            return pos[:2], neg[:2]

        dfs(0, -1)
        return ans